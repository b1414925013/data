const {
  app,
  BrowserWindow,
  Menu
} = require('electron')
const path = require('path')
const url = require('url')

// 保持一个对于 window 对象的全局引用，如果你不这样做，
// 当 JavaScript 对象被垃圾回收， window 会被自动地关闭
let win

function createWindow() {
  //隐藏关闭放大缩小最外层菜单栏目
  Menu.setApplicationMenu(null)

  // 创建浏览器窗口。
  win = new BrowserWindow({
    title: "hello electron",
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true, /**保证renderer.js可以使用require语句 */
      enableRemoteModule: true/**保证renderer.js可以可以正常require('electron').remote */
    },
    icon: __dirname + "/build/icon.ico"
  })

  // 然后加载应用的 index.html。
  win.loadURL(url.format({
    // pathname: path.join(__dirname, 'demo1.html'),
    // pathname: path.join(__dirname, 'demo2.html'),
    pathname: path.join(__dirname, 'demo3.html'),
    protocol: 'file:',
    slashes: true
  }))

  //打开开发者工具
  win.openDevTools()

  // 当 window 被关闭，这个事件会被触发。
  win.on('closed', () => {
    // 取消引用 window 对象，如果你的应用支持多窗口的话，
    // 通常会把多个 window 对象存放在一个数组里面，
    // 与此同时，你应该删除相应的元素。
    win = null
  })
}

// Electron 会在初始化后并准备
// 创建浏览器窗口时，调用这个函数。
// 部分 API 在 ready 事件触发后才能使用。
app.on('ready', createWindow)

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit()
  }
})

app.on("activate", () => {
  if (win === null) {
    createWindow()
  }
})