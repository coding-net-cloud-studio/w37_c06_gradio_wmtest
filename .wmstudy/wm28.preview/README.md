## 欢迎来到 Cloud Studio ##

这是一个展现 Cloud Studio 功能的 Python 示例。

##  自动预览 ##

之所以自动运行了这个应用并打开了预览窗口，是因为有 `.vscode/preview.yml` 文件存在。

该文件的格式说明如下：
```yml
# .vscode/preview.yml
autoOpen: true # 打开工作空间时是否自动开启所有应用的预览
apps:
  - port: 5000 # 应用的端口
    run: cat requirements.txt | xargs sudo pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com && python app.py # 应用的启动命令
    root: ./web # 应用的启动目录
    name: PythonDemo # 应用名称
    description: 我的第一个 Python 项目 # 应用描述
    autoOpen: true # 打开工作空间时是否自动开启预览（优先级高于根级 autoOpen
```

### 生成预览配置文件 ###
如果你想生成该文件，可以按下 <kbd>CMD+Shift+P</kbd>，打开命令面板，输入 `preview`，在命令列表中点击 **Preview: Generate Preview Config File**。

### 启动预览窗口 ###
有了这个文件后，你可以自己启动预览窗口。按下 <kbd>CMD+Shift+P</kbd>，打开命令面板，输入 `preview`，在命令列表中点击 **Preview: Open Preview Tab**。

##  手动开启预览调试 ##

1. 先进入到 `web` 目录，然后在终端直接运行 `cat requirements.txt | xargs sudo pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com && python app.py` 启动服务。

2. 完全启动之后，打开命令面板(`Command + Shift + P` 或 `Ctrl + Shift + P`) 并输入 `open preview tab`, 回车

![](./static/img2.png)

3. 输入端口号 `5000`，若端口被占用，可在 `application.properties` 文件里修改为其他端口号即可。回车后将自动打开预览窗口