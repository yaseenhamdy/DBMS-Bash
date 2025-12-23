#!/bin/bash

connect_to_database() {
    source "./database_func/list_database.sh"
    clear

    databases=("$DB_ROOT/"*)

    if [ ${#databases[@]} -eq 0 ]; then
        center "There is No Databases to connect"
    else
        center "||====== Available Databases ======||"
        echo ""
        list_database
        center "||=================================||"
        echo ""
        echo "Enter database number to connect: "
        read database_num

        valid_number="^[0-9]+$"

        if ! [[ "$database_num" =~ $valid_number ]]; then
            center "You must enter a number"
        elif (( database_num > ${#databases[@]} || database_num <= 0 )); then
            center "Entered number out of range"
        else
            selected_db="${databases[$database_num-1]}"
            database_name=$(basename "$selected_db")
            center "Connected to database: $database_name"
            source "./table_func/table_menu.sh"
            table_main_menu
        fi
    fi
}
