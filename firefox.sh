#!/bin/bash
if [[ -z "$(command -v docker)" ]];then
    echo "需要先安装Docker,可以使用下列脚本安装
    bash <(curl -sL haoduck.com/sh/docker.sh)"
else
    read -p "创建浏览器访问密码: " password
    read -p "运行的端口(默认5800): " port
    read -p "运行VNC的端口(默认不运行): " vncport
    [[ -z "$port" ]] && port=5800
    [[ -z "$password" ]] && password="password"
    [[ "$vncport" ]] && vnc="-p $vncport:5900" && echovnc="VNC端口:$vncport,VNC密码同浏览器访问密码"
    docker run -d \
        --name=firefox \
        $vnc \
        -e ENABLE_CJK_FONT=1 \
        -e VNC_PASSWORD=$password \
        -p $port:5800 \
        -v /docker/appdata/firefox:/config:rw \
        --shm-size 2g \
        jlesage/firefox
    echo "访问你的ip:$port,密码是$password.$echovnc"
    echo "如无法使用，请检查防火墙"
fi
