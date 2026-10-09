#!/bin/bash
# 把各个片段拼装成完整的课程页面。
# 在课程目录下运行：bash build.sh
set -e
cat _base.html modules/*.html _footer.html > index.html
echo "已生成 index.html —— 请用浏览器打开。"
