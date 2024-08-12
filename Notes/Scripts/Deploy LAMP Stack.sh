#!/bin/bash
function print_green(){
    GREEN="\033[0;32m"
    NC="\033[0m"
    echo -e "${GREEN} $1 ${NC}"
    }

# --------------- Database Configuration ---------------
# Install and configure FirewallD
print_green "Installing firewalld..."
sudo yum install -y firewalld
sudo service firewalld start
sudo systemctl enable firewalld

# Install and configure MariDB
print_green "Installing MariaDB..."
sudo yum install -y mariadb-server
sudo service mariadb start
sudo systemctl enable mariadb

# Add FirewallD rules for database
print_green "Adding Firewall rules for DB..."
sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload

# Configuring Database
print_green "Configuring DB..."
cat > configure-db.sql <<-EOF
CREATE DATABASE ecomdb;
CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
FLUSH PRIVILEGES;
EOF

sudo mysql < configure-db.sql

# Load Inventory Data into Database
print_green "Loading inventory data into DB..."
cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;

INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");

EOF

sudo mysql < db-load-script.sql


# --------------- Web Server Configuration ---------------
print_green "Configuring Web Server..."
#Install apache web server and php
sudo yum install -y httpd php php-mysqlnd

print_green "Configuring Firewall rules for web server..."
# Configure Firewall rules for web server
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --reload


sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

# Start and enable httpd service
print_green "Starting web server..."
sudo systemctl start httpd
sudo systemctl enable httpd

# Install GIT and download source code repository
print_green "Cloning Git Repo"
sudo yum install -y git
sudo git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/


#Replace databse IP with localhost
sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php
print_green "All Set."

#video paused at 15:38




