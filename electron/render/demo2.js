const BrowserWindow = require("electron").remote.BrowserWindow;
const path = require('path')
const url = require('url')
let newWin = null;
const btn = this.document.querySelector("#btn");
window.onload = function () {
    btn.onclick = () => {
        newWin = new BrowserWindow({
            width: 500,
            heigth: 500,
            webPreferences: {
                nodeIntegration: true
            }
        });
        newWin.loadURL(url.format({
            pathname: path.join(__dirname, 'yellow.html'),
            protocol: 'file:',
            slashes: true
        }))
        newWin.on("close", () => {
            newWin = null
        })
    }

}