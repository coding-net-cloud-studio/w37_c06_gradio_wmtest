#!/usr/bin/env bash

# NOTE 在club.cloudstudio.net中由于存储过小_下述安装会失败
pip install streamlit

# NOTE 在SaaS版本中存储容量足够_但是另外一个问题是_如下执行会无法正确访问

streamlit run p36_streamlit_video.py --server.enableCORS=false
