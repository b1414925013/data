# Config

## 常用配置

```json
{
    // 缩进
    "editor.tabSize": 2,
    // 代码中的文字大小
    "editor.fontSize": 20,
    // 终端窗口文字大小
    "terminal.integrated.fontSize": 18,
    // 窗口缩放，让整体界面字体放大
    "window.zoomLevel": 1,
}
```

## 快捷键

- 单行注释：Ctrl + /
- 多行注释：Shift + Alt + A
- 复制当前行：Shift + Alt + ↓
- 查看方法参数：Ctrl + Shift + 空格

## 可能会出现的问题

### 运行 tsc 命令时报错

错误信息如下：

法加载文件 C:\Users\xxx\AppData\Roaming\npm\tsc.ps1，因为在此系统上禁止运行脚本。有关详细信息，请参阅 ht tps:/go.microsoft.com/fwlink/?LinkID=135170 中的 about_Execution_Policies。

解决方式：

1：win+X启动 windows PowerShell（管理员）
2：输入 set-ExecutionPolicy RemoteSigned 命令，敲回车
3：提示输入内容时，输入 Y ，再敲回车即可。
