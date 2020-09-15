var fs = require("fs")
window.onload = function () {
    var btn = this.document.querySelector("#btn");
    var mybaby = this.document.querySelector("#mybaby");
    btn.onclick = function () {
        fs.readFile(__dirname +"/data/data.json", (err, data) => {
            console.log(data);
            mybaby.innerHTML = data
        })
    }
}