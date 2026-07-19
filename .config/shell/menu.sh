#!/usr/bin/env bash
# 此脚本用于用户环境变量目录下可执行脚本列表管理

USER_PATH=$HOME/.usr/menu

case $1 in

    --check)
        echo "Current Options:"
        if [ -d "$USER_PATH" ]; then
            for option in "$USER_PATH"/*; do
                [ -f "$option" ] && echo "$option"
            done
        exit 0
        else
            echo "No such file or directory!"
        fi
    ;;

    --add)
    ;;

    --del)
    ;;

    --edit)
    ;;

    --help | *)
        echo "Optional Commands:"
        echo "'menu --check' Show the current script(s) in the path dir."
        echo "'menu --add' Add a new script in the path dir."
        echo "'menu --del' Delete the target script."
        echo "'menu --edit' Edit the target script."
        echo "'menu --help' Show this message."
    ;;

esac
