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

# ==============================================================

# 在cloudstudio环境中_更新_vscode的_用户_settings_文件
# 主要是设置cloud studio为"永不休眠"
f16_cs_vs_settings_user_update(){
	# cloud studio中用户设置文件
	CS_VSCODE_SETTINGS_USER=/root/.local/share/code-server/data/User/settings.json
	# -----------------------------------------------------------
	# '嵌入文档涵盖了生成脚本的主体部分.

	(
	cat <<'EOF'
{
	"cloudstudio.autosleep": "no",
	"extensions.autoCheckUpdates": false,
	"extensions.autoUpdate": false,
	"update.mode": "none",
	"update.showReleaseNotes": false,
	"code-runner.runInTerminal": true
}
EOF
	) > ${CS_VSCODE_SETTINGS_USER}

	# 可能有用的设置_暂时被取消了
	# "Codegeex.Survey": false,
	# "CS.CodeAssistant.EnableExtension": false,
	# "go.toolsManagement.autoUpdate": true,

}


f20_linux_git_setting() {
	#在Linux操作系统环境下
	# git status中文显示乱码解决:
	# https://www.cnblogs.com/v5captain/p/14832597.html
	#相当于在~/.gitconfig 文件中加入一行 file:/root/.gitconfig   core.quotepath=false
	# core.quotepath=false
	git config --global core.quotepath false
	git config --global --add safe.directory $(pwd)

	# git config命令详解
	# http://www.mybatis.cn/archives/2151.html
	# git config --list --show-origin

	# 来自廖雪峰的git教程
	# https://www.liaoxuefeng.com/wiki/896043488029600/898732837407424
	git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

	git config --global alias.count "rev-list --all --count"

	# REVIEW 这里可能会有问题.立足解决,从本机上用tar.gz传输到cloud studio中直接解开.git用户信息的问题.
	# 相信,git clone模式,不会需要这个语句.
	git config --global --add safe.directory $(pwd)
}

# REVIEW 这个函数_是我自己加入的_安装一些函数
f23_install_some_software(){
	if [[ -f $(which cloudstudio) ]]; then
		apt update -y
		DEBIAN_FRONTEND=noninteractive apt install -y \
			iputils-ping \
			make \
			lsof net-tools \
			psmisc \
			file \
			sqlite3 libsqlite3-dev
	fi

	return 0
}

# ==============================================================

# NOTE 把06_样例目录拷贝到/workspace/下面去
l06_copy_06_example(){

	export v06_OLDPWD=$(pwd)

	if [[ ! -d /workspace/06_样例 ]]; then
		if [[ -d ./06_样例 ]]; then
			cp -r ./06_样例 /workspace/
		fi
	fi

	cd ${v06_OLDPWD}
	return 0
}

# NOTE 调用安装grasspy的脚本
l08_call_script_to_install_vscode_ext(){
	export v08_OLDPWD=$(pwd)

	if [[ -d /root/.pyenv/03_vscode_extension ]]; then
		cd /root/.pyenv/03_vscode_extension

		if [[ -f /root/.pyenv/03_vscode_extension/03_cloudstudio_install_vsix.sh ]]; then
			# NOTE 执行安装脚本
			./03_cloudstudio_install_vsix.sh
		fi
	fi

	cd ${v08_OLDPWD}
	return 0
}

# ==============================================================

# NOTE 下面是老版本p27的_这里不再调用了
l10_install_me(){

	export v10_OLDPWD=$(pwd)

	if [[ -f $(which cloudstudio) ]]; then
		if [[ -d /root/.pyenv ]]; then
			if [[ ! -d /root/.pyenv/03_vscode_extension ]]; then
				# NOTE 此时,还是原始状态_可以进行替换
					# 老的目录修改名称
					echo "正在处置原始的/root/.pyenv目录,时间较长,请耐心等待一小会"

					# NOTE 为了化简逻辑判断_不再区分SaaS版本的cloudstudio.net
					# 还是社区版本的club.cloudstudio.net的工作空间
					# 直接做出凶残的动作_把/root/.pyenv/目录直接地,彻底地,给删除了
					# mv /root/.pyenv /root/38_wmold_pyenv_这里是原始版本的pyenv
					rm -rf /root/.pyenv
					echo "正在把新的pyenv版本拷贝到/root/.pyenv/目录下"
					# 拷贝新的版本的pyenv到/root/.pyenv的位置
					cp -r $(pwd) /root/.pyenv

					# NOTE 把06_样例目录拷贝到/workspace/下面去
					l06_copy_06_example

					# NOTE 调用安装grasspy的脚本
					l08_call_script_to_install_vscode_ext

					echo "已经把/root/.pyenv更新为新的草莽grasspy3.10.1的版本了"
					echo "欢迎加入 草蟒极速 QQ 交流群:760167264 风里雨里,我们在那里等你 "
					echo "编程语言开发社区网址: https://www.ploc.org.cn/ploc/ "
					echo "我作为一名普通的"编程语言开放社区成员_与_grasspy.cn社区成员",以个人的身份,向吴烜xuan三声,凹语言群体,林纳斯·本纳第克特·托瓦兹(Linus Benedict Torvalds)等致敬!"
			else
				echo "已经执行过/root/.pyenv的替换操作_不需要再次进行"
			fi
		else
			echo "没有找到/root/.pyenv,无法进行后继操作"
		fi
	fi

	cd ${v10_OLDPWD}

	if [[ -f $(which cloudstudio) ]]; then
		if [[ -d /workspace/06_样例 ]]; then
			# 在cloudstudio.net中再打开一个窗口
			cloudstudio -n /workspace/06_样例
		fi
	fi

	return 0
}

# ==============================================================
# NOTE 针对club.cloudstudio.net社区版本
# NOTE 从github.com上获得git仓库建立工作空间以后
# NOTE 需要从gitee上获取新的pyenv环境
l30_git_clone_and_install_new_pyenv(){

	export v10_OLDPWD=$(pwd)

	# NOTE 判断是否_有必要_执行本函数
	# 如果没有_必要_再次执行_就return_0
	if [[ -f $(which cloudstudio) ]]; then
		if [[ -f /workspace/lock_01_run_me_已经被执行过一次_锁文件_不需要再次执行_wmgitignore.txt ]]; then 
			# 标志性的锁文件已经存在了
			if [[ -d /root/.pyenv/03_vscode_extension ]]; then 
				echo "没有必要再次执行_01_rum_me_的l30()函数"
				return 0
			fi
		fi
	fi

	

	if [[ -f $(which cloudstudio) ]]; then
		if [[ -d /root/.pyenv ]]; then
			if [[ ! -d /root/.pyenv/03_vscode_extension ]]; then

				# 如果发现_锁文件_把原有的那个文件删除
				# 后面会重新创建的
				[[ -f /workspace/lock_01_run_me_已经被执行过一次_锁文件_不需要再次执行_wmgitignore.txt ]] && rm /workspace/lock_01_run_me_已经被执行过一次_锁文件_不需要再次执行_wmgitignore.txt
				
				# NOTE 此时,还是原始状态_可以进行替换
					# 老的目录修改名称
					echo "正在处置原始的/root/.pyenv目录,时间较长,请耐心等待一小会"

					# NOTE 为了化简逻辑判断_不再区分SaaS版本的cloudstudio.net
					# 还是社区版本的club.cloudstudio.net的工作空间
					# 直接做出凶残的动作_把/root/.pyenv/目录直接地,彻底地,给删除了
					# mv /root/.pyenv /root/38_wmold_pyenv_这里是原始版本的pyenv

					[[ -d /root/.pyenv ]] && rm -rf /root/.pyenv

					echo "正在把新的pyenv版本_git_clone_到/root/.pyenv/目录下"
					# git_clone_新的版本的pyenv到/root/.pyenv的位置
					git clone --depth=1 https://gitee.com/coding_net_cloud_studio/ploc_grasspy_pyenv.git /root/.pyenv

					# NOTE 把06_样例目录拷贝到/workspace/下面去
					# l06_copy_06_example

					# NOTE 调用安装grasspy的脚本
					l08_call_script_to_install_vscode_ext

					echo "已经把/root/.pyenv更新为新的草莽grasspy3.10.1的版本了"
					echo "欢迎加入 草蟒极速 QQ 交流群:760167264 风里雨里,我们在那里等你 "
					echo "编程语言开发社区网址: https://www.ploc.org.cn/ploc/ "
					echo "我作为一名普通的"编程语言开放社区成员_与_grasspy.cn社区成员",以个人的身份,向吴烜xuan三声,凹语言群体,林纳斯·本纳第克特·托瓦兹(Linus Benedict Torvalds)等致敬!"

					touch /workspace/lock_01_run_me_已经被执行过一次_锁文件_不需要再次执行_wmgitignore.txt
			else
				echo "已经执行过/root/.pyenv的替换操作_不需要再次进行"
			fi
		else
			echo "没有找到/root/.pyenv,无法进行后继操作"
		fi
	fi

	cd ${v10_OLDPWD}

	# NOTE 如下的都不要再进行了
	# if [[ -f $(which cloudstudio) ]]; then
	# 	if [[ -d /workspace/06_样例 ]]; then
	# 		# 在cloudstudio.net中再打开一个窗口
	# 		cloudstudio -n /workspace/06_样例
	# 	fi
	# fi

	return 0
}


# ==============================================================
# NOTE 定义main()函数
main(){

	f16_cs_vs_settings_user_update

	f20_linux_git_setting

	f23_install_some_software

	# NOTE 下面是老版本p27的_这里不再调用了
	# l10_install_me

	# 需要从gitee上获取新的pyenv环境
	l30_git_clone_and_install_new_pyenv

	return 0
}

# ==============================================================

# NOTE 调用main()函数
main