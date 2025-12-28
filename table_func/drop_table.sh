#!/bin/bash

drop_table() {
    source "./table_func/list_tables.sh"

    list_tables
    while true; do
        read -p "Please enter the name of the table you want to delete: " file_name
        if [[ -z "$file_name" ]]; then
            echo "Table name cannot be empty."
            continue
        fi

        break
    done

    found=false


     table_file_del="$DB_ROOT/$database_name/$file_name.SQL"
     meta_file_del="$DB_ROOT/$database_name/.$file_name.SQL"


    for file in "$DB_ROOT/$database_name/"*".SQL"; do

    base="$(basename "$file")"
  
        if [ "$file_name.SQL" = "$base" ]; then
            [ -e "$file" ] || continue
            [ -f "$file" ] || continue
            rm -f "$table_file_del"
            rm -f "$meta_file_del"
            echo "Table '${base%.SQL}' deleted successfully"
            found=true
            break
        fi
    done

    $found || echo "Table not found"
}



