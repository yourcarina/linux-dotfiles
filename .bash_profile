#
# ~/.bash_profile
#

# 这里之所以不用 [ -f "~/.bashrc" ] 是因为 [] 会把引号内的内容当作字符串而不是把 ～ 解析为对应路径；[[]] 会直接解析 ～ 路径
if [[ -f ~/.bashrc ]]; then
  . ~/.bashrc
fi
