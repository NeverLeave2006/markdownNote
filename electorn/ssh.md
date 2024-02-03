以下是一个使用Electron、ssh2和node-pty创建SSH客户端的基本示例：

首先，你需要安装必要的依赖项：

```bash
npm install electron ssh2 node-pty
```

然后，你可以创建一个新的Electron应用。在你的`main.js`文件中，你可以使用以下代码：

```javascript
const { app, BrowserWindow } = require('electron')
const pty = require('node-pty')
const Client = require('ssh2').Client

function createWindow () {
  let win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
    }
  })

  win.loadFile('index.html')

  // 创建一个新的pty进程
  const shell = process.platform === 'win32' ? 'powershell.exe' : 'bash'
  const ptyProcess = pty.spawn(shell, [], {
    name: 'xterm-color',
    cols: 80,
    rows: 30,
    cwd: process.env.HOME,
    env: process.env
  })

  // 创建一个新的SSH客户端
  const conn = new Client()
  conn.on('ready', function() {
    console.log('Client :: ready')
    conn.exec('uptime', function(err, stream) {
      if (err) throw err
      stream.on('close', function(code, signal) {
        console.log('Stream :: close :: code: ' + code + ', signal: ' + signal)
        conn.end()
      }).on('data', function(data) {
        console.log('STDOUT: ' + data)
        // 将SSH输出写入pty进程
        ptyProcess.write(data)
      }).stderr.on('data', function(data) {
        console.log('STDERR: ' + data)
      })
    })
  }).connect({
    host: 'your_ssh_server',
    port: 22,
    username: 'your_username',
    password: 'your_password'
  })

  // 将pty进程的输出写入控制台
  ptyProcess.on('data', function(data) {
    process.stdout.write(data)
  })
}

app.whenReady().then(createWindow)
```

在这个示例中，我们创建了一个新的Electron窗口，然后创建了一个pty进程和一个SSH客户端。我们将SSH客户端的输出写入pty进程，然后将pty进程的输出写入控制台。

请注意，你需要将`your_ssh_server`、`your_username`和`your_password`替换为你的SSH服务器的地址、用户名和密码。