#!/bin/bash


connect_to_database() {
    source "./database_func/list_database.sh"
    clear

    databases=("$DB_ROOT"/*)

    if [ ${#databases[@]} -eq 0 ]; then
        center "There is No Databases to connect"
        return
    fi

    center "||====== Available Databases ======||"
    echo ""
    list_database
    center "||=================================||"
    echo ""

    read -p "Enter SQL command: " sql_input

    if [[ $sql_input =~ ^[[:space:]]*[Uu][Ss][Ee][[:space:]]+([a-zA-Z][a-zA-Z0-9_]*)[[:space:]]*\;?[[:space:]]*$ ]]; then

        database_name="${BASH_REMATCH[1]}"
        found=0

        for i in "${!databases[@]}"; do
            db_name=$(basename "${databases[$i]}")

            if [[ "$db_name" == "$database_name" ]]; then
                found=1
                selected_db="${databases[$i]}"
                database_name=$(basename "$selected_db")
                center "Connected to database: $database_name"
                source "./table_func/table_menu.sh"
                table_main_menu
                break
            fi
        done

        if [ $found -eq 0 ]; then
            center "Database '$database_name' not found"
        fi
    else
        center "Invalid SQL. Use: USE database_name;"
    fi
}


connect_to_database
