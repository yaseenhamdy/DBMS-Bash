main(){

   #!/bin/bash

rows=$(tput lines)
term_cols=$(tput cols)

source "./database_func/create_database.sh"
source "./database_func/list_database.sh"
source "./database_func/connect_to_database.sh"
source "./database_func/drop_database.sh"

DB_ROOT="./Databases"
valid_string="^[a-zA-Z][a-zA-Z0-9_]*$"

mkdir -p "$DB_ROOT"

center() {
    text="$1"
    clean_text=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    padding=$(( (term_cols - ${#clean_text}) / 2 ))
    (( padding < 0 )) && padding=0
    printf "%*s%s\n" "$padding" "" "$text"
}


while true;
do

clear

tput setaf 2
center "+---------------------------+"
center "| $(tput setaf 4)Welcome to our Bash DBMS !$(tput setaf 2) |"
center "| $(tput setaf 4)Written By: YASEEN & A'LAA $(tput setaf 2)|"
center "+---------------------------+"
center "| 1 - Create Database       |"
center "| 2 - List Databases        |"
center "| 3 - Connect Database      |"
center "| 4 - Drop Database         |"
center "| 5 - Exit                  |"
center "+---------------------------+"
tput setaf 4
echo -n "$(tput setaf 3)Choice : "
read choice
case $choice in
    1) create_Database
       read -p "Press Enter to continue..." 
       ;;
    2) list_database
       read -p "Press Enter to continue..." 
       ;;
    3) connect_to_database
       read -p "Press Enter to continue..." 
       ;;
    4) drop_database
       read -p "Press Enter to continue..." 
       ;;
    5) exit;;
    *) center "Invalid choice, please try again."
            echo "" 
            read -p "Press Enter to continue..."
            ;;

esac
done

}

main