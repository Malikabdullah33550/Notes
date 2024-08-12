#!/bin/bash
function print_green(){
    GREEN="\033[0;32m"
    NC="\033[0m"
    echo -e "${GREEN} $1 ${NC}"
    }
function print_blue(){
    BLUE="\033[0;34m"
    NC="\033[0m"
    echo -e "${BLUE} $1 ${NC}"
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





# --------------- Getting Credentials -------------------------

print_green "Enter Credentials"
read -sp "Enter Password for the root user of the Database: " ROOT_DB_PWD
read -p "Kindly enter the name for the domain before gunzdev.com:" DOMAIN_INITIALS
read -p "Enter the database name: " DB_NAME
read -p "Enter the username for creating USER in Database : " DB_USER


get_password() {
    while true; do
        # Prompt the user to enter the password
        read -sp "Enter your DB password: " DB_USER_PWD

        
        # Prompt the user to confirm the password
        read -sp "Confirm your DB password: " DB_USER_PWD_CONFIRM


        # Check if the passwords match
        if [ "$DB_USER_PWD" == "$DB_USER_PWD_CONFIRM" ]; then
            print_yellow "Passwords match."
            break
        else
            print_red "Passwords do not match. Please try again."
        fi
    done
}

# Call the function
get_password
