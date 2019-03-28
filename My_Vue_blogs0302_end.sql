SET NAMES UTF8;
DROP DATABASE IF EXISTS My_vue_blog;
CREATE DATABASE My_vue_blog CHARSET=UTF8;
USE My_vue_blog;
--创建一个在首页上展示文章的表[My_Index]
--#包含文章的Iid,文章的图片I_img,文章的标题I_title,文章的简介I_intro,文章的发布时间#I_time,文章详情的info_id,用户的阅读量dex_count
CREATE TABLE My_Index(
  dex_id      INT   PRIMARY KEY AUTO_INCREMENT,
  info_id     INT,
  dex_img     VARCHAR(100),
  dex_title   VARCHAR(520),
  dex_intro   VARCHAR(1200),
  dex_type    VARCHAR(100),
  dex_time    DATETIME,
  dex_count   INT
);
#插入首页的基本信息;
INSERT INTO My_Index VALUES(null,"1","http://127.0.0.1:3000/index_img/md5.jpg","数据库中md5()函数的使用","
md5,一种被广泛使用的密码散列函数，可以产生出一个128位（16字节）的散列值（hash value）,用于确保信息传输完整一致,当用户的密码不想被任何人看到时，可以使用md5()的方式进行加密","Mysql",now(),"100");
INSERT INTO My_Index VALUES(null,"2","http://127.0.0.1:3000/index_img/form.jpg","html5表单的新特性","
h5中提供了新的表单控件，比如 calendar、date、time、email、url、search， rangeautocomplete
autocomplete，autofocus，form，height 与 width，list，min 与 max，multiple，pattern (regexp)，
placeholder，required，step","HTML5",now(),"100");
INSERT INTO My_Index VALUES(null,"3","http://127.0.0.1:3000/index_img/close.jpg","
怎么理解JavaScript中的闭包","闭包:Scopes（压岁钱）是既重用变量有保护变量不被篡改的一种编程方法,闭包：是一个特殊的作用域对象，也称执行上下文","Javascript",now(),"100");
#创建一个显示首页文章的详情表
#当点击首页文章后跳转到文章的详情页面;
#包含的字段:文章的 info_id 文章的内容info_countent,
CREATE TABLE Index_info(
  info_id   INT,
  info_countent VARCHAR(2000)
);
INSERT INTO Index_info VALUES(1,"
  Md5,一种被广泛使用的密码散列函数，可以产生出一个128位（16字节）的散列值（hash value），用于确保信息传输完整一致,当用户的密码不想被任何人看到时，可以使用md5()的方式进行加密<br>
（1）、先举一个简单的栗子，当我们注册一个软件，或者某一个网站时，或者对银行卡的密码加密时，自己肯定不希望任何一个人知道自己的密码的，即便是后台的数据库中也不能直接将自己的密码显示出来，因为，如果后台的数据库中能够显示自己的密码，那，如果一些开发工作者心怀歹意，自己的信息还是有可能泄露出去的，那么，怎样使自己的密码，除了自己之外的任何人都不能知道呢？？<br>
（2）1991年，Rivest开发出技术上更为趋近成熟的md5算法，它是一种，不可逆的字符串变换算法。<br>
（3）对MD5算法简要的叙述可以为：MD5以512位分组来处理输入的信息，且每一分组又被划分为16个32位子分组，经过了一系列的处理后，算法的输出由四个32位分组组成，将这四个32位分组级联后将生成一个128位散列值。<br>
（4）通过这种算法，可以将用户的密码进行加密，<br>
（5）具体实现： 在mysql数据库有一个函数md5('')<br>
（6）sql语句“ SELECT id FROM xz_login WHERE uname = ? AND upwd = md5(?)”<br>
（1）小伙伴们，了解了，MD5的加密后，那么怎样提高MD5的加密效果呢，怎么防止自己的密码密码不被别人轻易的盗取呢？<br>
（2）我们可以在设置密码是采用数字，字母，下划线的方式进行加密，确保自己账号的安全！！！
");
INSERT INTO Index_info VALUES(2,
"(1)-datalist 建议列表,配合input创建建议列表，当用户不清楚如果输入内容提供建议
    ‘<datalist id=“list3”> 默认情况datalist不可见’ 
    <option>xx</option>
    <option>yy</option>
    </datalist>
    <input type=’text‘ list=’list3‘/><br>
(2)-progress 	进度条
    显示一个进度条两种形式
    <progress></progress> 左右晃动进度条
    <progress value=’0.7‘ /> 具有指定进度值进度条
    练习:使用定时器+进度条实现一个可以动态
    前进的前度条到 100%停止
    定时器 1s 修改value+0.1  到1结束<br>
 (3)-meter   	刻度尺
    <meter min=’最小值‘ max=’最大值‘ low=’下限‘high=’上限‘
    optimum=’最佳值‘ value=’当前值‘ />
    当前值离最佳值非常远   (红)危险
    当前值离最佳值比较近   (黄)警告
    当前值离最佳值非常近   (绿)正常<br>
(4)-output   	输出:语义标签,没有任何外观样式
    外观同span
    商品单价:￥3.50
    购买数量:<input type=‘number’ value=’2‘ />
    小计:<output>￥3.50</output> <br>
(5)新的属性 attr <input />
    h4:id;class;name;value;style;readonly;checked
    h5:
    -autofocus:   自动获取输入焦点
    -placeholder: 占位符
    -form:       用于把输入域放置在form外部 
    <form id=’f5‘>
    </form>
    <input type=‘text’  form=’f5‘/>
    -multiple:    允许输入多值(用逗号分隔) email
    a@a.com,b@b.com
    -验证相关 
    required:必填项，内容不能为空
    minlength;maxlength: 最小字符串长度
    min;max            数值最大值与最小值
    pattern             输入正则表达式
    <br>(6)h5:number;email;url;color;date;month;week
    更多相关资讯，请移步到，菜鸟教程，百度贴吧，xxx博客，还有更多的网站，小编已累，不想写了，往谅解！！！
");
INSERT INTO Index_info VALUES(3,"(1）闭包:Scopes（压岁钱）《是既重用变量有保护变量不被篡改的一种编程方法》<br>
（2）闭包：是一个特殊的作用域对象，也称”执行上下文”,是外层函数留给内层函数的专属作用域对象，专门用于为一个函数保护专属变量。<br>
（3）、今后只要希望既重用变量，又保护变量不被篡改时，就要用闭包为一个函数保管专属的变量。<br>
0、每次调用函数时，都会的临时创建函数作用域对象，所有函数都具有失忆症，但是闭包具有一个特殊的地方，内层函数有一个属性[[scopes]]，始终拴着自己可用的外层函数作用域，验证[[scopes]]，使用console.dir(外层函数将内层函数的返回值变量);(dir,是显示对象在内存中的结构，)
	<br>1、不能用全局变量的原因：缺点：极易容易被篡改，占用内存空间，造成空间资源的浪费；
优点：可以被重复使用，<br>
	2、函数中的局部变量：	缺点：不可重用，因为函数具有失忆症，每个函数执行一次，曾经用的内存清0，当做什么都没有发生过，当你再次调用该函数时，结果和第一次调用函数的结果是一样的；优点：不会被篡改<br>
	3、想要实现全局变量的重复使用，和局部变量的不会被篡改的功能------->《闭包三步曲》<br>
		（1）定义外层函数，包裹要保护的内层函数和内层变量；<br>
		（2）外层函数将内层函数返回到外部；<br>
		（3）如果想用内部函数，在外部调用外层函数，生成内层函数，并保存在变量中，此时的变量就相当于内层函数，然后在调用内层函数。<br>
	4、创建内层函数时，内层函数的[[scopes]]属性，始终拴着自己可用的外层函数作用域，<br> 
	5、父母的局部变量被留下来的原因是：孩子的[[scopes]]属性始终拉着父母不撒手；不能释放！！！<br>
闭包，含苞待放的花朵，多好看呀，没事赏赏花花草草，心情还是蛮不错的哦！！！");


#创建一个用户注册的表,包含的字段;用户的昵称:uname,用户邮箱email,用户密码upwd,
CREATE TABLE use_sigin(
    uid	   INT   PRIMARY KEY AUTO_INCREMENT,
    uname  VARCHAR(32),
    email  VARCHAR(50),
    upwd   VARCHAR(32),
    upwds  VARCHAR(32)
);
#创建用户评论文章的表comment。用来存储用户的评论的内容content，nid表示当前评论的id
#哪一个用户评论的uid,评论的时间ctime,评论的哪篇文章info_id,点赞的数量num,站长回复的内容my_callback
CREATE TABLE comment(
    nid INT   PRIMARY KEY AUTO_INCREMENT,
    info_id INT,
    uid  INT ,
    ctime DATETIME,
    content VARCHAR(100),
    my_callback VARCHAR(100),
    num INT
);
-- 创建一个用于存储图片的表，表名Spring
CREATE TABLE Spring(
    sp_id INT   PRIMARY KEY AUTO_INCREMENT,
    spr_img    VARCHAR(100)
);
-- 创建一个存储Summer图片的表 表名：Summer
CREATE TABLE Summer(
    su_id INT   PRIMARY KEY AUTO_INCREMENT,
    sum_img    VARCHAR(100)
);
-- 创建一个存储Autumn图片的表，Autumn
CREATE TABLE Autumn(
    au_id INT   PRIMARY KEY AUTO_INCREMENT,
    aut_img    VARCHAR(100)
);
-- 创建一个存储Winter图片的表 Winter
CREATE TABLE Winter(
    win_id INT   PRIMARY KEY AUTO_INCREMENT,
    win_img    VARCHAR(100)
);
-- 将Spring的图片存储到Spring的表中
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s1.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s2.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s3.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s4.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s5.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s6.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s7.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s8.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s9.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s10.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s11.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s12.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s13.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s14.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s15.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s16.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s17.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s18.jpg");
INSERT INTO Spring VALUES(null,"http://127.0.0.1:3000/Index_img/Life/Spring/s19.jpg");
-- 将Summer中的图片存放到Summer的表中;
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b1.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b2.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b3.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b4.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b5.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b6.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b7.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b8.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b9.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b10.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b11.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b12.jpg");
INSERT INTO Summer VALUES(null,"http://127.0.0.1:3000/Index_img/Life/summer/b13.jpg");
-- 将Autumn中的图片存放到Autumn中;
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a1.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a2.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a3.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a4.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a5.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a6.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a7.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a8.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a9.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a10.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a11.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a12.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a13.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a14.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a15.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a16.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a17.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a18.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a19.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a20.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a21.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a22.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a23.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a24.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a25.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a26.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a27.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a28.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a29.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a30.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a31.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a32.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a33.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a34.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a35.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a36.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a37.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a38.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a39.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a40.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a41.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a42.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a43.jpg");
INSERT INTO Autumn VALUES(null,"http://127.0.0.1:3000/Index_img/Life/autumn/a44.jpg");
-- 将冬天的图片存放到Winter的表中
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w1.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w2.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w3.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w4.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w5.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w6.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w7.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w8.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w9.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w10.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w11.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w12.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w13.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w14.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w15.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w16.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w17.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w18.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w19.jpg");
INSERT INTO Winter VALUES(null,"http://127.0.0.1:3000/Index_img/Life/winter/w20.jpg");

-- 留言板的实现
CREATE TABLE mesWall(
    mid INT PRIMARY KEY AUTO_INCREMENT,
    uid INT,
    mtime  DATETIME,
    msg VARCHAR(120),
    oid INT
);
-- 站长回复
CREATE TABLE OwnBack(
    oid    INT ,
    ownback VARCHAR(150),
    card VARCHAR(12),
    mid Int
);
-- 站长指令
CREATE TABLE card(
    own_id INT PRIMARY KEY AUTO_INCREMENT,
    card VARCHAR(32)
);
INSERT INTO card VALUES(null,"mhw1541371309@yeah.net");
-- 浅阅读深体会DetailsBook
CREATE TABLE DetailsBook(
   did INT PRIMARY KEY AUTO_INCREMENT,
   content VARCHAR(500),
   love INT,
   types VARCHAR(32)
);
-- 向浅阅读深体会DetailsBook中插入数据
INSERT INTO DetailsBook VALUES(null,"学会孤独，而不是习惯孤独，要发自内心的额昂自己喜欢一个人的日子",0,"哲理");
INSERT INTO DetailsBook VALUES(null,"一定要让自己变得优秀，不管时外表还是内在，同时告诉自己，我变得更好不是为了遇见那个对的人，而是让别人知道，不是单身选择了我，而是我选择了单身",0,"哲理");
INSERT INTO DetailsBook VALUES(null,"学会定期给自己的生活清零，扔掉不在穿的衣服，忘掉那个不在爱的人，一个总是回头看的人，时走不了远路的",null,"哲理");
INSERT INTO DetailsBook VALUES(null,"每个轻松的笑容背后，都是一个曾经咬紧牙关的灵魂，是一种坚韧",0,"哲理");
INSERT INTO DetailsBook VALUES(null,"命运，命是弱者的借口，运是强者的谦辞",0,"哲理");
INSERT INTO DetailsBook VALUES(null,"人一旦堕落，哪怕是短暂的几年，上帝就会以更快的速度收走你的天赋与力量",0,"哲理");
INSERT INTO DetailsBook VALUES(null,"人的一生会遇到两个人，一个惊艳了时光，一个温柔了岁月",0,"爱情");
-- CREATE TABLE love(
--     lid INT PRIMARY KEY AUTO_INCREMENT,
--     love INT,
--     did INT
-- )

-- 时光轴
CREATE TABLE timeline(
    tid INT PRIMARY KEY AUTO_INCREMENT,
    ttime DATETIME,
    title VARCHAR(300),
    tcontent VARCHAR(500)
);
INSERT INTO timeline VALUES(null,now(),"博客第一个时光轴","看到别人的博客都有自己的时光轴,用来记录自己的闲言碎语,感觉挺炫酷,于是经不住自己心中蛊虫的折磨,连三赶四的做了自己的时光轴,效果还不错,又想借鉴的可以联系我呀!!!");

INSERT INTO timeline VALUES(null,now(),"博客页面的完善","博客页面的基本思路已经完善了,本来只想着做两三个页面也就行了,没想到越做越多,停不住了,现在这个博客已经脱离了当时的心愿,但是,比原来计划的效果要好的多,功能也觉得高大上了起来,这可能就是不断学习,不断进步的结果吧,加油!!!");

INSERT INTO timeline VALUES(null,now(),"博客后台从现在开始","我是一个前端开发者,写起后台来,颇感费力,但是,没有办法呀,还是要硬着头皮上呀,不想找别人做,因为我想看着我自己的博客一点一点的成熟起来的样子,里面有我的思想,有我的灵魂,更有我不断学习的历程,加油");

INSERT INTO timeline VALUES(null,now(),"学习shi件枯燥的事","一个想要成功的人必定要经历,独自一个人的艰苦奋斗,可能一群人确实是走的远一点,但你要是落单了,可能别人也已经很累的情况下,成功与否就真的要看自己的了");

INSERT INTO timeline VALUES(null,now(),"24小时的时间点","小时候时间是按分钟过得,每次感觉下课前的5分钟是最难熬的,高中时,时间是按小时过得,当时的快乐起决与考场的那几个小时,现在时间按星期过的,一个星期也就只有那两个小时是自己玩游戏的时间,明明是同样的时间,但感觉上却越过越快了腻!");