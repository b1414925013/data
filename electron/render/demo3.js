const remote = require("electron").remote
const Menu = remote.Menu
const MenuItem = remote.MenuItem
const fs = require("fs")
const path = require("path")

//使用jquery点击
$("#btn").click(function () {
    alert("点击按钮")
})

//读取外部json文件
var url = "data/data.json" /*json文件url，本地的就写本地的位置，如果是服务器的就写服务器的路径*/
var request = new XMLHttpRequest();
request.open("get", url); /*设置请求方法与路径*/
request.send(null); /*不发送数据到服务器*/
request.onload = function () {
    /*XHR对象获取到返回信息后执行*/
    if (request.status == 200) {
        /*返回状态为200，即为数据获取成功*/
        var json = JSON.parse(request.responseText);

        console.log("一一一" + JSON.stringify(json));
    }
}

fs.readFile(path.resolve(__dirname, "data/data.json"), function (err, data) {
    console.log("二二二" + data)
})