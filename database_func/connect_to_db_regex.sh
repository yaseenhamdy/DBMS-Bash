#!/bin/bash

connect_to_database_sql() {
        source "./table_func/table_menu.sh"

    source "./database_func/list_database.sh"

    clear

    databases=("$DB_ROOT"/*)

    if [[ ! -e "${databases[0]}" ]]; then
        center "There is No Databases to connect"
        return
    fi

    center "||====== Available Databases ======||"
    echo ""
    list_database
    center "||=================================||"
    echo ""

    read -p "Enter SQL command  ex. USE database_name  or  use database_name: " sql_input

    if [[ $sql_input =~ ^[[:space:]]*[Uu][Ss][Ee][[:space:]]+([a-zA-Z][a-zA-Z0-9_]*)[[:space:]]*\;?[[:space:]]*$ ]]; then
        database_name="${BASH_REMATCH[1]}"
        selected_db="$DB_ROOT/$database_name"

        if [[ -d "$selected_db" ]]; then
            center "Connected to database: $database_name"
            table_main_menu
        else
            center "Database '$database_name' not found"
        fi
    else
        center "Invalid SQL. Use: USE database_name;"
        center "Example: USE mydb;"
    fi
}
