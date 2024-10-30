#!/bin/bash

# 定义可执行文件的路径
CLASH_EXEC="./clash-linux-amd64-n2023-09-05-gdcc8d87"

# 定义日志目录
LOG_DIR="./log"
CONFIG_DIR="$HOME/.config/clash"
CONFIG_NAME="config.yaml"

# 函数: 启动 Clash
start_clash() {
    # 创建日志目录如果不存在
    mkdir -p "$LOG_DIR"
    
    # 获取当前日期时间作为日志文件名的一部分
    log_time=$(date '+%Y-%m-%d_%H-%M-%S')
    log_file="$LOG_DIR/$log_time.log"
    
    # 使用 nohup 在后台启动 Clash 并重定向输出到日志文件
    echo "Starting Clash and logging to $log_file"
    nohup "$CLASH_EXEC" > "$log_file" 2>&1 &
}

# 函数: 检查 Clash 是否正在运行
is_clash_running() {
    local pid=$(pgrep clash-linux)
    if [ -n "$pid" ]; then
        echo "Clash is running with PID $pid."
        return 0
    else
        echo "Clash is not running."
        return 1
    fi
}

# 函数: 停止 Clash
stop_clash() {
    local pid=$(pgrep clash-linux)
    if [ -n "$pid" ]; then
        echo "Stopping Clash (PID $pid)"
        kill "$pid"
        echo "Clash has been stopped."
    else
        echo "No running Clash process found."
    fi
}

# 函数: 更新 Clash 配置
update_config() {
    # 读取配置文件的 URL
    sub_url=$(cat ./subscribe)
    
    # 打印配置文件的 URL
    echo "Configuration URL read from ./subscribe: $sub_url"
    
    # 下载配置文件
    mkdir -p "$CONFIG_DIR"
    wget -O "$CONFIG_DIR/$CONFIG_NAME" "$sub_url"
    
    echo "Configuration updated from $sub_url to $CONFIG_DIR/$CONFIG_NAME"
}

# 根据传入的第一个参数决定执行哪个操作
case "$1" in
    start)
        start_clash
        ;;
    stop)
	stop_clash
	;;
    restart)
        stop_clash
        is_clash_running || start_clash
        ;;
    update)
        update_config
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|update}"
        exit 1
        ;;
esac

exit 0
