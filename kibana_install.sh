#!/bin/bash

#下载kibana
wget --no-check-certificate https://artifacts.elastic.co/downloads/kibana/kibana-7.5.1-linux-x86_64.tar.gz
tar -xzf kibana-7.5.1-linux-x86_64.tar.gz
mv kibana-7.5.1-linux-x86_64 /usr/local/kibana
cd /usr/local/kibana/

#安装sentinl
#bin/kibana-plugin install https://github.com/sirensolutions/sentinl/releases/download/tag-6.6.0-0/sentinl-v6.6.1.zip

#修改配置文件
mv -f /home/kibana_install-master/kibana.yml /usr/local/kibana/config/kibana.yml
ip=$(/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v 172.17.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
sed -i "s/localhost/$ip/g" /usr/local/kibana/config/kibana.yml

#开机启动
mv /home/kibana_install-master/kibana /etc/init.d
cd /etc/init.d
chmod +x kibana
chkconfig --add kibana

#启动kibana
service kibana start
echo "启动中......."
