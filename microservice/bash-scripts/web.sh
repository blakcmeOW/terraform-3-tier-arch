#!/bin/bash
apt update
apt install unzip -y
apt install wget nginx -y
systemctl start nginx
systemctl enable nginx
wget --content-disposition https://www.tooplate.com/download/2134_gotto_job
unzip 2134_gotto_job.zip
cp -r 2134_gotto_job/* /var/www/html/
systemctl restart nginx