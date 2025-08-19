#!/usr/bin/env bash

APP_NAME="$1"
KEY="$2"

BASE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hotkeys"
SET_NAME="${APP_NAME}"

declare -A APP_GROUPS
#邮件客户端
APP_GROUPS[microsoft_outlook]="mail"
APP_GROUPS[网易邮箱大师]="mail"
APP_GROUPS[邮件]="mail"
APP_GROUPS[spark]="mail"

#邮件网页
APP_GROUPS[safari浏览器]="browser"
APP_GROUPS[microsoft_edge]="browser"
APP_GROUPS[google_chrome]="browser"
APP_GROUPS[firefox]="browser"
APP_GROUPS[brave_browser]="browser"

#检查当前应用是否需要分组
if [[ -n "${APP_GROUPS[$SET_NAME]}" ]]; then
    SET_NAME="${APP_GROUPS[$SET_NAME]}"
fi

#可执行程序的名字就是ctrl + option + command + 1/2/3/a/b/c中的1/2/3/a/b/c,没有后缀,可以是一个bash脚本,也可以是一个编译后的可执行文件
EXECUTABLE_PROGRAM="$BASE_DIR/sets/$SET_NAME/$KEY"

if [[ -x "$EXECUTABLE_PROGRAM" ]]; then
    "$EXECUTABLE_PROGRAM" &
else
    osascript -e "display notification \"寻找后台执行脚本错误:$EXECUTABLE_PROGRAM\" with title \"hotkeys\" sound name \"Glass\""
fi
