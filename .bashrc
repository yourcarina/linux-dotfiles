#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 命令别名设置
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# 终端提示符设置
PS1='[\u@\h \W]\$ '

# 环境变量设置

# repo 清华镜像
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'

# 启用 ccache 缓存加速编译
export USE_CCACHE=1
ccache -M 64G

# 添加用户环境变量目录
USER_PATH=$HOME/.usr/bin
CARGO_PATH=$HOME/.cargo/bin
PATH=$PATH:$USER_PATH:$CARGO_PATH

# 代理设置

PROXY_USER=${USER}
PROXY_PASSWORD="proxy-password"

function proxy-on {
    export http_proxy="http://${PROXY_USER}:${PROXY_PASSWORD}@127.0.0.1:7890"
    export https_proxy="https://${PROXY_USER}:${PROXY_PASSWORD}@127.0.0.1:7890"
    export socks="socks5://${PROXY_USER}:${PROXY_PASSWORD}@127.0.0.1:7891"
    export socks5="socks5://${PROXY_USER};${PROXY_PASSWORD}@127.0.0.1:7891"
    export all_proxy="socks5://${PROXY_USER}:${PROXY_PASSWORD}@127.0.0.1:7893"
    export no_proxy="localhost,127.0.0.1,*.local,::1"
}

function proxy-off {
    unset http_proxy
    unset https_proxy
    unset socks_proxy
    unset socks5_proxy
    unset all_proxy
    unset no_proxy
}
