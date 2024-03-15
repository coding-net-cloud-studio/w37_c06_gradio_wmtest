#! /usr/bin/make -f 

all:
	@# 下面是_正式的_入口
	bash 10.wmscript_init_this.sh 
	@# 下面是用于_测试的_入口
	@# bash 10.wmscript_init_this.sh f99_test_1st_func 2nd 3rd

exec_10_script_test:
	@# 下面是用于测试的
	@# bash 10.wmscript_init_this.sh 
	@# bash 10.wmscript_init_this.sh f82_services_start 2nd 3rd
	@# bash 10.wmscript_init_this.sh f99_test_1st_func 2nd 3rd

wmtask_runonce: 
	@# TODO runonce适合安装韩俊大神的coderunner扩展. 
	@# 这样,保证不运行很重的all构建目标,就可以用coderunner去工作了.
	@echo -e "占位符号\n"


