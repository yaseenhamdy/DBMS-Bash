#!/bin/bash

drop_database_sql(){
    clear
    source "./database_func/list_database.sh"
    

 center "||======== Current databases ========||"

   list_database
center "||====================================||"
    read -p "Enter SQL command  ex. DROP DATABASE database_name  or  drop database database_name: " sql_input

    if [[ $sql_input =~ ^[[:space:]]*[Dd][Rr][Oo][Pp][[:space:]]+[Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee][[:space:]]+([a-zA-Z][a-zA-Z0-9_]*)[[:space:]]*\;?[[:space:]]*$ ]]; then
        dbName="${BASH_REMATCH[1]}"
        db_path="$DB_ROOT/$dbName"

        if [ -d "$db_path" ]; then
            rm -r "$db_path"
            center "Database '$dbName' dropped successfully."
        else
            center "Database '$dbName' does not exist."
        fi
    else
        center "Invalid SQL. Use: DROP DATABASE database_name;"
        center "Example: DROP DATABASE mydb;"
    fi
}