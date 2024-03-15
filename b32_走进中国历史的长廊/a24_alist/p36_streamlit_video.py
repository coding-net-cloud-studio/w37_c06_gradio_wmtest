# Copyright (c) Streamlit Inc. (2018-2022) Snowflake Inc. (2022)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os

import streamlit as st

# These are the formats supported in Streamlit right now.
VIDEO_EXTENSIONS = ["mp4", "ogv", "m4v", "webm"]

# For sample video files, try the Internet Archive, or download a few samples here:
# http://techslides.com/sample-webm-ogg-and-mp4-video-files-for-html5


# st.title("Video Widget Examples")

# st.header("Local video files")
# st.write(
#     "You can use st.video to play a locally-stored video by supplying it with a valid filesystem path."
# )


def get_video_files_in_dir(directory):
    out = []
    for item in os.listdir(directory):
        try:
            # NOTE 原始的下述代码遇到_类似_p09.ex5_更多的变量和打印.mp4_出错_会跳转到_except处理去
            # name, ext = item.split(".")
            # NOTE 我变更的_开始
            name = item.split(".")[:-1]
            ext = item.split(".")[-1]

            print(name)
            print(ext)
            # NOTE 我变更的_结束
        except:
            print("这里出错")  # NOTE 我变更的
            continue
        if name and ext:
            if ext in VIDEO_EXTENSIONS:
                out.append(item)
    return out


# NOTE 我变更的
avdir = os.path.expanduser("/workspace/06_样例/a24_alist/videos")
files = get_video_files_in_dir(avdir)

if len(files) == 0:
    st.write(
        "Put some video files in your home directory (%s) to activate this player."
        % avdir
    )

else:
    filename = st.selectbox(
        "从如下的目录中选择一个视频 (%s) 去播放" % avdir,
        files,
        0,
    )

    st.video(os.path.join(avdir, filename))
# st.header("Remote video playback")
# st.write("st.video allows a variety of HTML5 supported video links, including YouTube.")


# def shorten_vid_option(opt):
#     return opt.split("/")[-1]


# # A random sampling of videos found around the web.  We should replace
# # these with those sourced from the streamlit community if possible!
# # 从东北横跨黑龙江,赶俄罗斯早市!中俄边境一江之隔的城市什么样?
# # https://www.bilibili.com/video/BV1hQ4y1777C
# vidurl = st.selectbox(
#     "选取一个视频播放",
#     (
#         "https://www.bilibili.com/video/BV1hQ4y1777C",
#     ),
#     0,
#     shorten_vid_option,
# )

# st.video(vidurl)
