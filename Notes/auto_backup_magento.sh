#!/bin/bash


function print_green(){
    GREEN="\033[0;32m"
    NC="\033[0m"
    echo -e "${GREEN} $1 ${NC}"
}
function print_yellow(){
    YELLOW="\033[0;33m"
    NC="\033[0m"
    echo -e "${YELLOW} $1 ${NC}"
}
function print_red(){
    RED="\033[0;31m"
    NC="\033[0m"
    echo -e "${RED} $1 ${NC}"
}
function print_blue(){
    BLUE="\033[0;34m"
    NC="\033[0m"
    echo -e "${BLUE} $1 ${NC}"
}

print_green "Backing up Crucial Files"

# current date and time
CURRENT_DATE_TIME=$(date +"%Y%m%d_%H%M%S")

# source files
SOURCE_SSL="/etc/httpd/conf.d/ssl.conf"
SOURCE_MAGENTO="/etc/httpd/conf.d/magento.conf"

# destination directory
DESTINATION_DIR="/etc/httpd/backup/"

# Create the backup directory if it doesn't exist
if [ ! -d "$DESTINATION_DIR" ]; then
    print_blue "Backup directory does not exist. Creating $DESTINATION_DIR..."
    mkdir -p "$DESTINATION_DIR"
else
    print_yellow "Backup directory exists: $DESTINATION_DIR . Taking Backup Now"
fi

# Backup Files
DESTINATION_SSL="${DESTINATION_DIR}backup_${CURRENT_DATE_TIME}_ssl.conf"
DESTINATION_MAGENTO="${DESTINATION_DIR}backup_${CURRENT_DATE_TIME}_magento.conf"


# Copy the files with the new names
cp -a "$SOURCE_SSL" "$DESTINATION_SSL"
cp -a "$SOURCE_MAGENTO" "$DESTINATION_MAGENTO"

if [ -f "$DESTINATION_SSL" ]; then
     print_yellow "Backup created as: $DESTINATION_SSL"
else
     print_red "Backup Failed for $DESTINATION_SSL"
fi

if [ -f "$DESTINATION_MAGENTO" ]; then
     print_yellow "Backup created as: $DESTINATION_MAGENTO"
else
     print_red "Backup Failed for $DESTINATION_MAGENTO"
fi