#!/bin/bash

create_database_sql() {
    center "|| Creating a new database... ||"
    echo ""
    read -p "Enter SQL command  ex. CREATE DATABASE database_name or create database database_name: " sql_input 

    if [[ $sql_input =~ ^[[:space:]]*[Cc][Rr][Ee][Aa][Tt][Ee][[:space:]]+[Dd][Aa][Tt][Aa][Bb][Aa][Ss][Ee][[:space:]]+([a-zA-Z][a-zA-Z0-9_]*)[[:space:]]*\;?[[:space:]]*$ ]]; then
        database_name="${BASH_REMATCH[1]}"

        if [[ -d "$DB_ROOT/$database_name" ]]; then
            center "Database '$database_name' already exists"
        else
            mkdir -p "$DB_ROOT/$database_name"
            center "Database '$database_name' created successfully"
        fi
    else
        center "Invalid SQL statement. Use: CREATE DATABASE db_name;"
    fi
}
