#!/bin/bash  
set -e  
# 尝试获取与 main.py 相关的最后一个进程的 PID
pid=$(pgrep -f main.py | tail -n 1)

# 检查 pid 变量是否被设置了值（即 pgrep 是否找到了进程）
if [ -z "$pid" ]; then
    # 如果 pid 为空（即 pgrep 没有找到进程），则设置 pid 为 2
    pid=2
fi

# 接收第一个命令行参数作为bookname  
if [ -z "$1" ]; then  
    echo "请提供bookname作为参数"  
    exit 1  
fi  
  
bookname=$1  
  
# 使用bash数组来存储字符串  
strings=("sy" "ybj" "txp" "lswj" "lrsp" "qhpz")  
  
# 使用循环和字符串比较来检查bookname是否在列表中  
is_found=false  
for str in "${strings[@]}"; do  
    if [[ " $str " == *" $bookname "* ]]; then  
        is_found=true  
        break  
    fi  
done  
  
if $is_found; then  
    cd /root/codearts/APIGW-python-sdk-2.0.5 && python3 main.py "$bookname" "$pid"  &  
    # 如果需要，可以保存进程ID  
    exit 0  
else  
    echo "$bookname 不在列表中"  
    exit 1  
fi
