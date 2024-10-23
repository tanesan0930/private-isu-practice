#!/bin/bash

set -xe
cd golang && make && cd -
now=$(date +%Y%m%d-%H%M%S)

for h in 1
do
   rsync -lOrtcv  --exclude '.git' ./ isucon${h}:/home/isucon/private_isu/webapp/
   ssh isucon${h} sudo systemctl restart isu-go.service
   ssh isucon${h} sudo cp /home/isucon/private_isu/webapp/nginx${h}.conf /etc/nginx/nginx.conf
   ssh isucon${h} sudo systemctl restart nginx
   ssh isucon${h} sudo cp /home/isucon/private_isu/webapp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
   ssh isucon${h} sudo systemctl restart mysql
done

# nginx ログのローテーション
# for h in 1
# do
#    ssh isucon${h} sudo touch /var/log/nginx/access.log
#    ssh isucon${h} sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
#    ssh isucon${h} sudo systemctl restart nginx
# done

# mysql ログのローテーション
# for h in 1
# do
#    ssh isucon${h} sudo touch /var/log/mysql/mysql-slow.log
#    ssh isucon${h} sudo mv /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$now
#    ssh isucon${h} sudo mysqladmin flush-logs
#    ssh isucon${h} sudo systemctl restart mysql
# done