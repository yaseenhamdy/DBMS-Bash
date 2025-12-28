#!/bin/bash
create_table() {

   
    while true; do
        read -p "Table Name: " tableName

        if ! [[ "$tableName" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
            echo "Invalid table name (letters, numbers, _, start with letter)"
            continue
        fi

        if [[ -f "$DB_ROOT/$database_name/$tableName.SQL"  ]]; then
            echo "Table already exists, choose another name"
        else
            break
        fi
    done


   
    while true; do
        read -p "Number of Columns: " colsNum
        if [[ "$colsNum" =~ ^[0-9]+$ ]] && (( colsNum >= 1 )); then
            break
        else
            echo "Error: enter a valid number (>=1)"
        fi
    done


    cols=()
    types=()
    counter=2


   
    while true; do
        read -p "Primary key column name: " pk_name

        if [[ "$pk_name" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
            break
        else
            echo "Invalid PK name"
        fi
    done

    select pk_type in "int" "str"; do
        case $pk_type in
            int|str) break ;;
            *) echo "invalid choice" ;;
        esac
    done


    while [ $counter -le $colsNum ]; do

        while true; do
            clear
            read -p "Name of column $counter: " colName

            # name format
            if ! [[ "$colName" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
                echo "Invalid column name"
                continue
            fi

            # not equal PK
            if [[ "$colName" == "$pk_name" ]]; then
                echo "Column name cannot be same as primary key"
                continue
            fi

            # unique
            if [[ " ${cols[*]} " == *" $colName "* ]]; then
                echo "Duplicate column name"
                continue
            fi

            break
        done

        select colType in "int" "str"; do
            case $colType in
                int|str)
                    cols+=("$colName")
                    types+=("$colType")
                    break
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
        done

        ((counter++))
    done


   
    columns=()
    columns+=("${pk_name}:${pk_type}")

    for (( i=0; i<${#cols[@]}; i++ )); do
        columns+=("${cols[i]}:${types[i]}")
    done

    columns_str=$(IFS=_; echo "${columns[*]}")


    awk -v columns="$columns_str" '
    BEGIN {
        n = split(columns, arr, "_")
        for (i = 1; i <= n; i++) {
            print arr[i]
        }
    }' > "$DB_ROOT/$database_name/.$tableName.SQL"


    touch "$DB_ROOT/$database_name/$tableName.SQL"

    echo "Table '$tableName' created successfully!"
}
