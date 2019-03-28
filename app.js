//app.js
//1:加载模块 express pool.js
const express = require("express");
const pool = require("./pool");

//2:创建服务器端对象
var app = express();
//3:监听 3000
app.listen(5050,()=>{
  console.log("服务器创建成功")
});
//4:指定静态目录  public 
app.use(express.static("public"));
//引入cros进行跨域请求
const cors=require("cors")
//配置跨域访问模块，哪个域名跨域访问允许
//脚手架8080允许；
//origin:指允许跨域访问域名的列表；
//credentials跨域访问保存session id
app.use(cors({
  origin:["http://127.0.0.1:8080","http://localhost:8080"],
  credentials:true
}))  
//配置express-session，用于保存用户的uid从而判断用户是否登录
//只需在用户登录成功前获取用户的uid并将其保存在session对象中
//可以使用：var id=result[0].id,req.session.iod=id;
const session=require("express-session");
app.use(session({
  secret:"128位随机字符",//获取安全字符串共128位；
  resave:false,       //是否每次请求的时候都要更新数据，不更新
  saveUninitialized:true,//初始化时保存数据
  cookie:{
    maxAge:1000*60*60*8 //定义保存用户在浏览器浏览的过程中保存的时间是8个小时
  }
}))
//引入模块body-parser，可以进行post请求
const bodyParser=require("body-parser");
//配置对特殊的json是否自动转换-->不转化
app.use(bodyParser.urlencoded({extended:false}))

//功能一、创建轮播图的组件，从服务器中获取轮播图的图片
app.get("/swipe_img",(req,res)=>{
 var list=[
    {id:1,swipe_img:"http://127.0.0.1:3000/Index_img/img/1.jpeg"},
    {id:2,swipe_img:"http://127.0.0.1:3000/Index_img/img/2.jpeg"},
    {id:3,swipe_img:"http://127.0.0.1:3000/Index_img/img/3.jpeg"},
    {id:4,swipe_img:"http://127.0.0.1:3000/Index_img/img/4.jpeg"},
    {id:5,swipe_img:"http://127.0.0.1:3000/Index_img/img/5.jpeg"}]
    res.send(list)
})
//功能二;首页文章信息的显示从数据库获得数据表My_Index的所有数据,
//并根据插入的id的顺序进行排序,从而达到,按时间顺序排序的目的;
//并按分页的方式查找数据库中的信息;
app.get("/index1",(req,res)=>{
  var pno=req.query.pno;
  var pageSize=req.query.pageSize;
  if(!pno){
    pno=1;
  }
  if(!pageSize){
    pageSize=5;
  }
  // console.log(pno,pageSize)
  var sql="SELECT * FROM my_index order by dex_id desc  LIMIT ?,?";
  var offset=(pno-1)*pageSize;
  var pageSize=parseInt(pageSize);
  // console.log(offset,pageSize)
  pool.query(sql,[offset,pageSize],(err,result)=>{
    if(err) throw err;
    // console.log(result)
    if(result.length>0){
      res.send({code:1,data:result})
    }else{
      res.send({code:-1,mag:"没有获取到数据"})
    }
  })
})
//功能三:实现点击首页的图片跳转到文章的详情页的时候,阅读的数量加一的操作
 app.get("/addinfo",(req,res)=>{
  var dex_count=req.query.dex_count
  var dex_id=req.query.dex_id;
  var sql=`UPDATE my_index SET dex_count=${dex_count} WHERE dex_id=${dex_id} `
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    res.send({code:1,data:result})
  })
})
//功能四：实现点击首页文章的图片跳转到文章的详情页的效果，
// 文章的详情页面创建了文章的详情表Index_info
//需要根据首页某一个文章的info_id找到对应的文章的信息；并采用多表查询的方式获取，
// 创建文章的时间，文章的类型，文章的内容；
app.get("/indexinfo",(req,res)=>{
    var  info_id=parseInt(req.query.info_id);
    var  sql="SELECT * FROM Index_info i , my_index m  WHERE  i.info_id=m.info_id AND i.info_id=?"
    pool.query(sql,[info_id],(err,result)=>{
      if(err) throw err;
      if(result.length>0){
        res.send({code:1,data:result})
      }else{
        res.send({code:-1,msg:"此文章暂时未开放！！！"})
      }
    })
}) ;
//功能五,实现用户的注册
app.post("/sigin",(req,res)=>{
  var obj=req.body;
  // console.log(obj)
  var $uname=obj.uname;
  var $email=obj.email;
  var $upwd=obj.upwd;
  var $upwds=obj.upwds;
  var sql="INSERT INTO use_sigin VALUES(?,?,?,md5(?),md5(?))";
  pool.query(sql,[null,$uname,$email,$upwd,$upwds],(err,result)=>{
    if(err)throw err;
    if(result.affectedRows>0){
      res.send({code:1,data:"恭喜注册成功！！！"})
    }else{
      res.send({code:0,data:"注册失败，请重新注册！！！"})
    }
  })
})
//功能六:用户的登录
app.get("/login",(req,res)=>{
  var obj=req.query;
  var $email=obj.email;
  var $upwds=obj.upwds;
  var sql="SELECT * FROM use_sigin WHERE email=? AND upwds=md5(?)";
  pool.query(sql,[$email,$upwds],(err,result)=>{
  if(err)throw err;
  if(result.length>0){
    // console.log(result)
    //保存用户登录的状态，保存用户的uid
    var uid=result[0].uid
    req.session.uid=uid;
    // console.log(req.session.uid)
    res.send({code:1,data:"登录成功!!!"})
  }else{
    res.send({code:0,msg:"登录失败！！！"})
  }
  })
})
// 功能七、实现用户的对文章的评论
//没有登录的用户禁止评论
//创建用户评论文章的表comment
app.get("/comment",(req,res)=>{
  var obj=req.query;
  var uid=req.session.uid; //用户的id,用来判断用户是否登录
  var info_id=obj.info_id; //文章的id,用来判断用户对哪篇文章进行的评论
  var content=obj.content; //用户评论的内容.
  console.log(uid)
  if(isNaN(uid)){         //判断用户是否进项了登录,
    res.send({code:0,msg:"请登录后评论!!!"})
    return;
  }else{
    var sql="INSERT INTO comment VALUES(?,?,?,now(),?,?,?)"
    pool.query(sql,[null,info_id,uid,content,null,100],(err,result)=>{
      if(err) throw err;
      // console.log(result)
      if(result.affectedRows>0){
        res.send({code:1,msg:"评论成功!!!"})
      }else{
        res.send({code:-1,msg:"评论失败!!!"})
      }
    })
  }
})
// 功能八:将用户评论的内容显示出来SELECT * FROM my_index order by dex_id desc  LIMIT ?,?
app.get("/getcomment",(req,res)=>{
  var info_id=parseInt(req.query.info_id)
  var sql="SELECT c.nid,c.ctime,c.content,c.num,c.my_callback,c.uid,u.uname From  comment c, use_sigin u  WHERE  c.uid=u.uid  AND c.info_id=? order by c.nid desc"
  pool.query(sql,[info_id],(err,result)=>{
    // console.log(result)
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,data:result})  
    }else{
      res.send({code:-1,msg:"获取评论失败!!"})
    }
  })  
})
//功能八:用户点赞:没有登录的用户也可以进行点赞
app.get("/help",(req,res)=>{
  var obj=req.query;
  var num=obj.num;
  var nid=obj.nid;
  // var info_id=obj.info_id
  // console.log(obj)
  var sql=`UPDATE comment SET num=${num} WHERE nid=${nid}`;
  // console.log(sql)
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    // console.log(result)
    if(result.affectedRows>0){
      res.send({code:1,msg:"谢谢你的点赞!!"})
    }else{
      res.send({code:-1,msg:"没有点赞!!"})
    }
  })
})
//功能九:游客或管理员进行评论, 
app.get("/admincomment",(req,res)=>{
  var obj=req.query;
  var nid=parseInt(obj.nid);
  var my_callback=obj.admincomment;
  if(!my_callback){
    res.send({code:1,msg:"不打算评论吗?"})
    return;
  }
  var sql=`UPDATE comment SET my_callback="${my_callback}" WHERE nid=${nid}`
  // var sql=`INSERT INTO comment (my_callback) VALUES(?) WHERE nid=${nid}`
  pool.query(sql,[my_callback],(err,result)=>{
    if(err) throw err
    // console.log(result)
    if(result.affectedRows>0){
      res.send({code:1,msg:"回复成功!!!"})
    }else{
      res.send({code:-1,msg:'回复失败!!!'})
    }
  })
})
//将视频发送出去
app.get("/video",(req,res)=>{
  var list=[
    {vid:1,video_url:"http://127.0.0.1:3000/Index_img/video.mp4"}
  ]
  res.send({code:1,data:list})
})
//将春天的图片发送出去
app.get("/spring",(req,res)=>{
  var sql="SELECT *FROM spring"
  pool.query(sql,(err,result)=>{
    // console.log(result)
    if(err)throw err
    if(result.length>0){
      res.send({code:1,data:result})
    }else{
      res.send({code:-1,msg:"数据不存在"})
    }
  })
})
//将夏的图片发送出去
app.get("/summer",(req,res)=>{
  var sql="SELECT *FROM summer"
  pool.query(sql,(err,result)=>{
    // console.log(result)
    if(err)throw err
    if(result.length>0){
      res.send({code:1,data:result})
    }else{
      res.send({code:-1,msg:"数据不存在"})
    }
  })
})
//将夏的图片发送出去
app.get("/autumn",(req,res)=>{
  var sql="SELECT *FROM autumn"
  pool.query(sql,(err,result)=>{
    // console.log(result)
    if(err)throw err
    if(result.length>0){
      res.send({code:1,data:result})
    }else{
      res.send({code:-1,msg:"数据不存在"})
    }
  })
})
//将冬的图片发送出去
app.get("/winter",(req,res)=>{
  var sql="SELECT *FROM winter"
  pool.query(sql,(err,result)=>{
    // console.log(result)
    if(err)throw err
    if(result.length>0){
      res.send({code:1,data:result})
    }else{
      res.send({code:-1,msg:"数据不存在"})
    }
  })
})
// 留言板的实现
app.get("/insertwell",(req,res)=>{
  var obj=req.query;
  var msg=obj.msg;
  var oid=1;
  var uid=req.session.uid;
  if(isNaN(uid)){
    res.send({code:-1,msg:"请先登录"})
  }else{
    var sql="INSERT INTO mesWall  VALUES(null,?,now(),?,?)"
    pool.query(sql,[uid,msg,oid],(err,result)=>{
      if(err) throw err;
      if(result.affectedRows>0){
        res.send({code:1,msg:"成功留言"})
      }else{
        res.send({code:-1,msg:"留言失败"})
      }
    })
  }
})
// 获取留言信息
app.get("/getwell",(req,res)=>{
  var sql="SELECT m.mid,m.msg,m.mtime,u.uname FROM mesWall m,use_sigin u WHERE m.uid=u.uid order by m.mid desc"
  pool.query(sql,(err,result)=>{
    // console.log(result)  
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,data:result})
    }else{
      res.send({code:-1,msg:"没有此数据"})
    }
  })
})
// 站长回复
app.get("/ownback",(req,res)=>{
  var obj=req.query;
  var msgback=obj.msgback;
  var mid=obj.mid;
  var card=obj.card;
  if(card!=0000){
    res.send({code:-1,msg:"你不是站长吧"})
  }else{
    var sql="INSERT INTO OwnBack VALUES(1,?,?,?)"
    // console.log(obj)
    pool.query(sql,[msgback,card,mid],(err,result)=>{
      if(err) throw err;
      // console.log(result)  
      if(result.affectedRows>0){
        res.send({code:1,msg:"回复成功"})
      }
    })
  }
})
// 获取站长回复的消息
app.get("/getback",(req,res)=>{
  var obj=req.query;
  var sql="SELECT o.ownback,o.mid FROM OwnBack o,mesWall m  WHERE o.mid=m.mid"
  // console.log(obj)
  pool.query(sql,(err,result)=>{
    // console.log(result)
    if(err) throw err;
     if(result.length>0){
      res.send({code:1,data:result})   
    }else{
      res.send({code:-1,msg:"数据不存在"})
    }
  })
})
// 站长的指令信息
app.get("/card",(req,res)=>{
  var obj=req.query;
  // console.log(obj)
  var card=obj.value;
  var sql="select * from card WHERE card=?"
  pool.query(sql,[card],(err,result)=>{
    // console.log(result)
    if(result.length>0){
      res.send({code:1,msg:"操作成功"})
    }else{
      res.send({code:-1,msg:"请联系站长"})
    }
  })
})
// 获取数据DetailsBook表中的数据，发送给Details.vue 中显示
app.get("/detailsBook",(req,res)=>{
  var sql="SELECT * FROM DetailsBook order by did desc"
  pool.query(sql,(err,result)=>{
  // console.log(result)    
  if(err) throw err;
  if(result.length>0){
    res.send({code:1,data:result})
  }else{
    res.send({code:-1,msg:"获取信息失败"})  
  }
})
})
// 将点赞的数量添加到数据库中
app.get("/love",(req,res)=>{
  var obj=req.query;
  // console.log(obj)
  var did=obj.did;
  var love=obj.num;
  var sql=`UPDATE DetailsBook SET love="${love}" WHERE did=${did}`
  // console.log(sql)
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    // console.log(result)
    if(result.affectedRows>0){
      res.send({code:1,msg:"谢谢点赞"})
    }
  })
})
// 将点赞的数量发送给对应的列表
app.get("/getLove",(req,res)=>{
  var sql="SELECT love,did FROM DetailsBook"
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    // console.log(result)
    if(result.length>0){
      res.send({code:1,data:result})
    } else{
      res.send({code:-1,msg:"没找到"})
    }
  })  
})
// 请求一下时间轴的内容
app.get("/getTime",(req,res)=>{
  var sql="SELECT *FROM timeline order by tid desc"
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,data:result})
    }
  })
})