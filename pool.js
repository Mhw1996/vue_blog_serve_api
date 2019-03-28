//1:引入mysql库
const mysql = require("mysql");
//2:创建连接池
var pool = mysql.createPool({
//  host:"127.0.0.1",
//  user:"root",
//  password:"",
//  database:"my_vue_blog",
//  port:3306,
//  connectionLimit:20
		host     : process.env.MYSQL_HOST,
    port     : process.env.MYSQL_PORT,
    user     : process.env.ACCESSKEY,
    password : process.env.SECRETKEY,
    database : 'app_' + process.env.APPNAME
});
//3:导出连接池对象
module.exports = pool;