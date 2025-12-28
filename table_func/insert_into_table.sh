insert_into_table() {
    clear
        source "./table_func/list_tables.sh"
        list_tables

    read -p "Enter table name: " tableName

    meta="$DB_ROOT/$database_name/.$tableName.SQL"
    data="$DB_ROOT/$database_name/$tableName.SQL"

    if [[ ! -f "$meta" || ! -f "$data" ]]; then
        echo " Table does not exist"
        return
    fi

 
    IFS=: read pk pk_type < <(head -n 1 "$meta")

    columns=()
    types=()

   
    while IFS=: read col type
    do
        columns+=("$col")
        types+=("$type")
    done < "$meta"

    values=()

    for i in "${!columns[@]}"
    do
        while true
        do
            read -p "Enter ${columns[$i]} (${types[$i]}): " value

            
            if [[ "${types[$i]}" == "int" ]]; then
                [[ "$value" =~ ^[0-9]+$ ]] || { echo " Must be integer"; continue; }      
            fi

            values[$i]="$value"
            break
        done
    done

   
    pk_index=0

    if cut -d:  -f$((pk_index+1)) "$data" | grep -xq "${values[$pk_index]}"; then
        center " Primary key already exists"
        return
    fi

    
    row=$(IFS=:; echo "${values[*]}")

    echo "$row" >> "$data"

    center " Record inserted successfully"
}

