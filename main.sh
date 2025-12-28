#!/bin/bash

main(){


rows=$(tput lines)
term_cols=$(tput cols)

source "./database_func/create_database.sh"
source "./database_func/list_database.sh"
source "./database_func/connect_to_database.sh"
source "./database_func/drop_database.sh"
source "./database_func/create_db_regex.sh"
source "./database_func/connect_to_db_regex.sh"
source "./database_func/drop_database_regex.sh"

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
    1)
    while true; do
        clear
        tput setaf 2
        center "+------------------------------+"
        center "|   Create Database Method     |"
        center "+------------------------------+"
        center "| 1 - Wizard                   |"
        center "| 2 - SQL Query                |"
        center "| 3 - Back                     |"
        center "+------------------------------+"
        tput setaf 4
        echo -n "$(tput setaf 3)Choice : "
        read method_choice

        case $method_choice in
            1)
                create_Database          
                read -p "Press Enter to continue..."
                break
                ;;
            2)
                create_database_sql      
                read -p "Press Enter to continue..."
                break
                ;;
            3)
                break
                ;;
            *)
                center "Invalid choice, please try again."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
    ;;

    2) list_database
       read -p "Press Enter to continue..." 
       ;;
    3)
    while true; do
        clear
        tput setaf 2
        center "+------------------------------+"
        center "|   Connect Database Method    |"
        center "+------------------------------+"
        center "| 1 - Wizard                   |"
        center "| 2 - SQL Query                |"
        center "| 3 - Back                     |"
        center "+------------------------------+"
        tput setaf 4
        echo -n "$(tput setaf 3)Choice : "
        read method_choice

        case $method_choice in
            1)
                connect_to_database         
                read -p "Press Enter to continue..."
                break
                ;;
            2)
                connect_to_database_sql      
                read -p "Press Enter to continue..."
                break
                ;;
            3)
                break
                ;;
            *)
                center "Invalid choice, please try again."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
    ;;

    4)
    while true; do
        clear
        tput setaf 2
        center "+------------------------------+"
        center "|   Drop Database Method       |"
        center "+------------------------------+"
        center "| 1 - Wizard                   |"
        center "| 2 - SQL Query                |"
        center "| 3 - Back                     |"
        center "+------------------------------+"
        tput setaf 4
        echo -n "$(tput setaf 3)Choice : "
        read method_choice

        case $method_choice in
            1)
                drop_database         
                read -p "Press Enter to continue..."
                break
                ;;
            2)
                drop_database_sql      
                read -p "Press Enter to continue..."
                break
                ;;
            3)
                break
                ;;
            *)
                center "Invalid choice, please try again."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
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
