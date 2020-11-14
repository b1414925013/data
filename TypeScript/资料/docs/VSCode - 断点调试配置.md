# VSCode - 断点调试配置

注意：`VSCode`调试TS代码是需要配置的。

## 配置步骤

### 第一步：准备要调试的ts文件

新建 `a.ts` 文件，作为要调试的ts文件

```js
console.log('1 准备开始执行 for 循环')

for (let i: number = 1; i <= 3; i++) {
  console.log('...一锅装不下')
}

console.log('2 for 循环执行结束')
```

### 第二步：添加调试配置

1. 打开调试窗口：点击左侧活动栏倒数第二个按钮（Debug）
2. 生成默认配置：点击DEBUG后面的下拉框，选择添加配置
3. 修改配置内容如下：

```js
{
  // 使用 IntelliSense 了解相关属性。 
  // 悬停以查看现有属性的描述。
  // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "调试TS代码",
      // ts-node 命令： “直接”运行ts代码。
      // 作用：调试时加载ts-node包（在调试时“直接”运行ts代码）
      "runtimeArgs": ["-r", "ts-node/register"],
      // 此处的 a.ts 表示要调试的 TS 文件（ 可修改为其他要调试的ts文件 ）
      "args": ["${workspaceFolder}/a.ts"]
    }
  ]
}
```

### 第三步：安装调试用到的包

1. 在当前目录中，打开终端窗口
2. 在终端中输入以下命令：

```bash
# 注意：原来通过 -g（全局）安装的包，在调试时不生效，需要在当前目录中单独安装
# 调试TS代码，依赖这两个包
npm i ts-node typescript
```

## 调试技巧

- 查看 `console.log` 输出（调试控制台）

- 监视变量的值（1 鼠标移入  2 **添加到左侧监视窗口**）

