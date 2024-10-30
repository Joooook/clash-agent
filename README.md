# clash-agent
A Bash script provides simple cli control functions for Clash.

简易clash控制脚本

## Installation
```
git clone https://github.com/Joooook/clash-agent.git
cd clash-agent
wget https://github.com/zhongfly/Clash-premium-backup/releases/download/2023-09-05-gdcc8d87/clash-linux-amd64-n2023-09-05-gdcc8d87.gz
```

## Usage
Copy your subscribe link (.e.g http://example.com/api/subscribe?token=xxxx&flag=clash) into ./subscribe

注意是clash的配置文件,一般带有`&flag=clash`参数

```
./agent.sh {start|stop|restart|update}

- start: start clash
- stop: kill clash process
- restart: restart clash
- update: download config.yaml from link in ./subscribe  
```

## Note
- Only support one subscribe link.
- Generate logs in ./log


- 只支持一条订阅。
- 日志文件位于./log。

## Others
https://github.com/zhongfly/Clash-premium-backup
