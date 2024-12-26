#!/bin/bash
apt update
apt install unzip -y
apt install wget apache2 -y
systemctl start apache2
systemctl enable apache2
wget --content-disposition https://www.tooplate.com/download/2134_gotto_job
unzip 2134_gotto_job.zip
cp -r 2134_gotto_job/* /var/www/html/
systemctl restart apache2