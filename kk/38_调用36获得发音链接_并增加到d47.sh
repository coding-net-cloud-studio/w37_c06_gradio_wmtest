#!/usr/bin/env bash

pip install beautifulsoup4

python 36_获得单词的发音链接.py $1 | tee -a d47_中国程序员发错音的单词.hdnb
