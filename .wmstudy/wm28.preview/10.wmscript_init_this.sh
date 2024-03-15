#! /bin/bash


pause_60_second(){
    if read -t 60 -p "暂停60秒,按回车继续运行: "
    then
        # echo "hello $REPLY,welcome to cheng du"
        printf "\n";
    else
        # echo "sorry, Output timeout, please execute the command again !"
        printf "\n时间已到,继续运行\n";
    fi
}


f20_linux_git_setting() {
    #在Linux操作系统环境下
    # git status中文显示乱码解决:
    # https://www.cnblogs.com/v5captain/p/14832597.html
    #相当于在~/.gitconfig 文件中加入一行 file:/root/.gitconfig   core.quotepath=false
    # core.quotepath=false
    git config --global core.quotepath false
    git config --global --add safe.directory $(pwd) 

    # 来自廖雪峰的git教程
    # https://www.liaoxuefeng.com/wiki/896043488029600/898732837407424
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
}



f30_install_common_software(){
    apt install -y \
        tree \
        curl \
        net-tools \
        lsof \
        htop \
        psmisc \
        screen \
        screenfetch \
        direnv \
        pv \
        strace \
        rsync \
        sshfs \
        ansible 

}

f36_install_gcc_10_versioin(){
	apt install -y gcc-10 
	apt install -y g++-10 
	rm /usr/bin/gcc  
    rm /usr/bin/g++  
	ln -s /usr/bin/gcc-10 /usr/bin/gcc 
	ln -s /usr/bin/g++-10 /usr/bin/g++  
}


f53_mysql_func_install_for_cloud_studio(){
    # 来自cloud studio的如下文档
    # https://cloudstudio.net/docs/programming/middleware.html
	apt install -y mysql-server mysql-client
	mkdir -p /nonexistent && service mysql start 
    # mysql 
        # show databases;
        # use mysq;
        # show tables;
        # desc user;
        # select count(*) from user;
}

f55_redis_func_install_for_cloud_studio(){
    # 来自cloud studio的如下文档
    # https://cloudstudio.net/docs/programming/middleware.html
	apt install -y redis-server 

    # 注意这里有问题，需要修改一下 /etc/init.d/redis-server 文件，
    # 找到 start-stop-daemon -v --start --umask 007 --pidfile $PIDFILE --chuid redis:redis --exec $DAEMON -- $DAEMON_ARGS 行，
    # 去掉 --chuid redis:redis ，否则服务无法正常停止。
    if [ -f /etc/init.d/redis-server.wmraw ]; then 
        echo -e "已经处理过了/etc/init.d/redis-server文件,不需要再次处理\n"
    else 
        cp /etc/init.d/redis-server /etc/init.d/redis-server.wmraw
        sed -i 's/--chuid redis:redis//' /etc/init.d/redis-server
    fi 

    service redis-server start

    # redis-cli --raw
        #  keys *
        # set 城市 北京
        # get 城市

}

f57_mongodb_func_install_for_cloud_studio(){
    # 来自cloud studio的如下文档
    # https://cloudstudio.net/docs/programming/middleware.html
	apt-get install -y mongodb
	service mongodb start 
    # mongo
        # db
        # db.createCollection('test')
        # db.test.insert({ 我爱你: "中国" })
        # db.test.find()

        # 切换到admin数据库
        # use admin
        # 创建管理员账号
        # db.createUser({ user: "cs", pwd: "123456", roles: ["root"] })
        # 创建完成后退出 mongo 命令行
        # exit

    # 修改 mongodb 服务配置
    # vim /etc/mongodb.conf
    # 在文件末尾添加以下配置
    # auth = true
    
    # mongodb service 没有提供 stop 命令, 手动停掉进程
    # ps aux | grep mongodb | awk '{print $2}' | head -n 1 | xargs kill

    # 使用上面创建的账号连接 mongodb
    # mongo -u cs -p 123456 --authenticationDatabase admin
}


f70_set_go_env(){

    go env -w GO111MODULE=auto ; \
	go env -w GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct ; \
	echo "export GO111MODULE=auto" >> ~/.profile ; \
	echo "export GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct" >> ~/.profile ; \
	echo "export GO111MODULE=auto" >> ~/.zshrc ; \
	echo "export GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct" >> ~/.zshrc ; \
	echo "export GO111MODULE=auto" >> ~/.bashrc ; \
	echo "export GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct" >> ~/.bashrc 
}

f72_go_mod_download(){

    # 下面的是给廖显东,廖老师的goAdvanced代码仓库增加go.mod文件用到的
    # go mod init gitee.com/shirdonl/goAdvanced

    # GO111MODULE=auto GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct go build -v -x ./... 2>&1 | grep "go get" | sort | xargs -n3 -I {}  bash -c '{}'

    # GO111MODULE=auto GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct go mod download -x 

    # GO111MODULE=auto GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct go mod tidy 


    if [ -f $(pwd)/go.mod ]; then 
        GO111MODULE=auto GOPROXY=https://goproxy.cn,https://mirrors.tencent.com/go/,https://mirrors.aliyun.com/goproxy,https://proxy.golang.com.cn,direct go mod download -x 
    else 
        echo -e "不存在go.mod文件,不需要执行go mod download -x 命令\n"
    fi 



}

f80_services_status(){

    # echo -e "\033[30m 黑色字 \033[0m"
    # echo -e "\033[31m 红色字 \033[0m"
    # echo -e "\033[32m 绿色字 \033[0m"
    # echo -e "\033[33m 黄色字 \033[0m"
    # echo -e "\033[34m 蓝色字 \033[0m" 
    # echo -e "\033[35m 紫色字 \033[0m" 
    # echo -e "\033[36m 天蓝字 \033[0m" 
    # echo -e "\033[37m 白色字 \033[0m" 

    # 查询_mysql数据库服务的_状态
    if [ -f /etc/init.d/mysql ]; then 
            service mysql status 
            echo -e "\n"
            ps -ef | grep mysqld | grep -v grep
            if [[ $(ps -ef | grep mysqld | grep -v grep | wc -l) -gt 0 ]]; then 
                # echo -e "mysql is running\n"
                echo -e "\033[33m mysql 正在运行 \033[0m\n"
            else 
                echo -e "\033[33m mysql 服务停止 \033[0m\n"
                echo -e "\n"
            fi 
            echo -e "\n"
        else 
            echo -e "\033[33m mysql 尚未安装 \033[0m\n" 
    fi

    # 查询_redis内存noSQL数据库服务的_状态
    if [ -f /etc/init.d/redis-server ]; then 
            # service redis-server status 
            if [[ $(service redis-server status | grep "redis-server is running" | wc -l) -gt 0 ]]; then 
                echo -e "\033[33m redis 正在运行 \033[0m\n"
            else 
                echo -e "\033[33m redis 服务停止 \033[0m\n"
            fi 
            echo -e "\n"
        else 
            echo -e "\033[33m redis 尚未安装 \033[0m\n"   
    fi

    # 查询_mongodb文档noSQL数据库服务的_状态
    if [ -f /etc/init.d/mongodb ]; then 
            service mongodb status 
            # 通过ps的方法查询
            ps aux | grep mongodb | grep -v grep 
            if [[ $(ps aux | grep mongodb | grep -v grep | wc -l) -eq 0 ]]; then 
                # echo -e "mongodb is not running\n"
                echo -e "\033[33m mongodb 服务停止 \033[0m\n"
            else 
                # echo -e "mongodb is running\n"
                echo -e "\033[33m mongodb 正在运行 \033[0m\n"
                
            fi
            echo -e "\n"
        else 
           echo -e "\033[33m mongodb 尚未安装 \033[0m\n" 
    fi

}

f82_services_start(){

    # 启动mysql数据库服务
    if [ -f /etc/init.d/mysql ]; then 
        mkdir -p /nonexistent && service mysql start
        echo -e "\n"
    fi

    # 启动redis内存noSQL数据库服务
    if [ -f /etc/init.d/redis-server ]; then 
        service redis-server start
        echo -e "\n"
    fi

    # 启动mongodb文档noSQL数据库服务
    if [ -f /etc/init.d/mongodb ]; then 
        service mongodb start
        echo -e "\n"
    fi

    # 查询一下各个服务的状态
    f80_services_status

}


f84_services_stop(){

    # 停止mysql数据库服务
    if [ -f /etc/init.d/mysql ]; then 
        service mysql stop
        echo -e "\n"
    fi

    # 停止redis内存noSQL数据库服务
    if [ -f /etc/init.d/redis-server ]; then 
        service redis-server stop
        echo -e "\n"
    fi

    # 停止mongodb文档noSQL数据库服务
    if [ -f /etc/init.d/mongodb ]; then 
        # mongodb service 没有提供 stop 命令, 手动停掉进程
        echo -e "Stopping mongodb: mongodb.\n"
        ps aux | grep mongodb | awk '{print $2}' | head -n 1 | xargs kill
        echo -e "\n"
    fi

    # 查询一下各个服务的状态
    f80_services_status

}




f92_2828_main(){

    # 目前把apt update单独放在这里
    apt update 

    # pause_60_second
    f20_linux_git_setting
    f30_install_common_software 
    f36_install_gcc_10_versioin

    # 安装mysql,redis,mongodb等主要服务
    f53_mysql_func_install_for_cloud_studio
    f55_redis_func_install_for_cloud_studio
    f57_mongodb_func_install_for_cloud_studio

    # go语言环境的设置与处理在下面的区段中
    f70_set_go_env
    f72_go_mod_download

}

# ---------------------------------------------------------------------------------------

# 下面是用于测试的
f98_test_main(){
    echo -e "\n执行了_f98_test_main_缺省入口函数\n"
}

f99_test_1st_func(){
    echo -e "\n执行了_f99_test_1st_func_作为入口函数\n"
    echo -e "\n传递到函数内部的参数为: " $* "\n"
}

# ---------------------------------------------------------------------------------------

# 缺省执行main函数作为入口
# eval f92_2828_main

# ---------------------------------------------------------------------------------------

# 如下是_测试_的入口
# 第1个参数,$1,如果是空字符串，则执行正文
# [ -z "$1" ] && echo "执行缺省入口函数" || echo "执行 第1个参数 指定的函数 ----> $1 "


# 如果 第1个参数,$1,没有值传递进来,就是用缺省的,入口函数 f92_2828_main
# 反之 可以用 ./10.wmscript_init_this.sh f99_test_1st_func 2nd 3rd 4th 去进行测试.我们把所有的参数$*都传递给被eval的函数了.
# 测试语句如下
# ./10.wmscript_init_this.sh f99_test_1st_func 2nd 3rd 4th
# [ -z "$1" ] && eval f98_test_main || eval $1 $* 


# 下面是_正式_的入口
[ -z "$1" ] && eval f92_2828_main || eval $1 $* 


# ---------------------------------------------------------------------------------------

# echo $* 

# for arg in $* ; do 
#     echo -e "第 $# 个参数 "  ${arg}."\n" ;
# done


# ---------------------------------------------------------------------------------------

# 有4种执行格式 

# 第1种:
#     直接在linux的终端的命令行中执行_没有参数
#     或通过vscode的扩展coderunner直接点击执行_没有参数
#     通过 ./10.wmscript_init_this.sh

        # 此时 $0 为 "./10.wmscript_init_this.sh"
        # 此时 $1 为 ""

        # echo -e '\n第1种情况--->\n'
        # echo -e '此时 被执行的_bash_shell_执行脚本名称后面_衔接的_后继_参数_数目  为'   $# "\n"
        # echo '此时 第0个参数 为:'  $0 
        # echo '此时 第1个参数 为:'  $1 
        # echo '取出的被执行的bash脚本名称是:' $(basename "$0")
        # echo -e "\n"

# ---------------------------------------------------------------------------------------


# 第2种:
#     直接在linux的终端的命令行中执行_带有后继参数
#     通过 ./10.wmscript_init_this.sh f82_services_start 2nd 3rd

        # 此时 第0个参数 为: ./10.wmscript_init_this.sh
        # 此时 第1个参数 为: f82_services_start
        # 此时 第2个参数 为: 2nd
        # 此时 第3个参数 为: 3rd
        # 取出的被执行的bash脚本名称是: 10.wmscript_init_this.sh

        # echo -e '\n第2种情况--->\n'
        # echo -e '此时 被执行的_bash_shell_执行脚本名称后面_衔接的_后继_参数_数目  为'   $# "\n"
        # echo '此时 第0个参数 为:'  $0 
        # echo '此时 第1个参数 为:'  $1 
        # echo '此时 第2个参数 为:'  $2 
        # echo '此时 第3个参数 为:'  $3 
        # echo '取出的被执行的bash脚本名称是:' $(basename "$0")
        # echo -e "\n"


# ---------------------------------------------------------------------------------------

# 第3种:
#     位于Makefile中_后面后面没有参数
#     通过 bash 10.wmscript_init_this.sh

        # 此时 $0 为 "10.wmscript_init_this.sh"
        # 此时 $1 为 ""

        # echo -e '\n第3种情况--->\n'
        # echo -e '此时 被执行的_bash_shell_执行脚本名称后面_衔接的_后继_参数_数目  为'   $# "\n"
        # echo '此时 第0个参数 为:'  $0 
        # echo '此时 第1个参数 为:'  $1 
        # echo '此时 第2个参数 为:'  $2 
        # echo '此时 第3个参数 为:'  $3 
        # echo '取出的被执行的bash脚本名称是:' $(basename "$0")
        # echo -e "\n"

# ---------------------------------------------------------------------------------------

# 第4种: 
#     位于Makefile中_后面带有参数的_下面的样例中_带有3个参数_是_f82_services_start 2nd 3rd
#     通过 bash 10.wmscript_init_this.sh f82_services_start 2nd 3rd

        # 此时 第0个参数 为: 10.wmscript_init_this.sh
        # 此时 第1个参数 为: f82_services_start
        # 此时 第2个参数 为: 2nd
        # 此时 第3个参数 为: 3rd
        # 取出的被执行的bash脚本名称是: 10.wmscript_init_this.sh

        # echo -e '\n第4种情况--->\n'
        # echo -e '此时 被执行的_bash_shell_执行脚本名称后面_衔接的_后继_参数_数目  为'   $# "\n"
        # echo '此时 第0个参数 为:'  $0 
        # echo '此时 第1个参数 为:'  $1 
        # echo '此时 第2个参数 为:'  $2 
        # echo '此时 第3个参数 为:'  $3 
        # echo '取出的被执行的bash脚本名称是:' $(basename "$0")
        # echo -e "\n"

# ---------------------------------------------------------------------------------------




