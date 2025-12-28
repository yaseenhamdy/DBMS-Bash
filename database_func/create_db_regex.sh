#!/bin/bash
center() {
    echo "===================="
    echo "$1"
    echo "===================="
}

create_Database() {
    center "|| Creating a new database... ||"
    echo ""
    read -p "Enter SQL command: " sql_input

    if [[ $sql_input =~ ^[[:space:]]*[Cc][Rr][Ee][Aa][Tt][Ee][[:space:]]+[Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee][[:space:]]+([a-zA-Z][a-zA-Z0-9_]*)[[:space:]]*\;?[[:space:]]*$ ]]; then 
        database_name="${BASH_REMATCH[1]}"

        if [ -d "$DB_ROOT/$database_name" ]; then
            center " Database '$database_name' already exists"
        else
            mkdir  "$DB_ROOT/$database_name"
            center "Database '$database_name' created successfully"
        fi
    else
        center " Invalid SQL statement. Use: CREATE DATABASE db_name;"
    fi
}

create_Database

