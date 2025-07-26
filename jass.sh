#!/bin/bash

echo "Starting user data script" > /home/ubuntu/debug.txt

touch /home/ubuntu/heyyy.txt
sudo apt-get update -y >> /home/ubuntu/debug.txt
sudo apt-get install nginx -y >> /home/ubuntu/debug.txt
sudo systemctl start nginx >> /home/ubuntu/debug.txt
sudo systemctl enable nginx >> /home/ubuntu/debug.txt

echo "<h1> Hey Babyy, We will make it big. </h1>" > /var/www/html/index.html
