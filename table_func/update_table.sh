update_table() {

    clear
    list_tables
    echo ""

    while true; do
        read -p "Enter table name: " table_name

        if [[ -z "$table_name" ]]; then
            center "Table name cannot be empty."
            continue
        fi

        if [[ ! -f "$DB_ROOT/$database_name/$table_name.SQL" || ! -f "$DB_ROOT/$database_name/.$table_name.SQL" ]]; then
            center "Table does not exist."
            continue
        fi
        break
    done

    meta_file_upd="$DB_ROOT/$database_name/.$table_name.SQL"
    data_file_upd="$DB_ROOT/$database_name/$table_name.SQL"

    pk_name=$(awk -F: 'NR==1 {print $1}' "$meta_file_upd")
    pk_type=$(awk -F: 'NR==1 {print $2}' "$meta_file_upd")


    echo ""
   center "||======== Current data ========||"

   while IFS= read -r line; do
      center "$line"
   done < "$DB_ROOT/$database_name/$table_name.SQL"

center "||=================================||"

    echo ""


    while true; do
        read -p "Enter primary key value of the row to update: " primary_key_val

        if [[ -z "$primary_key_val" ]]; then
            center "Primary key cannot be empty."
            continue
        fi

        if [[ "$pk_type" == "int" ]]; then
            if ! [[ "$primary_key_val" =~ ^[0-9]+$ ]]; then
                center "Primary key must be an integer."
                continue
            fi
        else
            if [[ "$primary_key_val" == *:* ]]; then
                center "Primary key cannot contain ':'"
                continue
            fi
        fi

        if grep -q "^$primary_key_val:" "$data_file_upd"; then
            break
        else
            center "No row found with primary key value: $primary_key_val"
        fi
    done

    old_row=$(grep "^$primary_key_val:" "$data_file_upd")
    echo ""
    echo "Current row:"
    echo "$old_row"
    echo ""

    col_names=()
    col_types=()

    while IFS=: read -r c_name c_type; do
        col_names+=("$c_name")
        col_types+=("$c_type")
    done < "$meta_file_upd"

    echo "Choose column to update:"
    for (( i=0; i<${#col_names[@]}; i++ )); do
        echo "$((i+1))) ${col_names[i]} (${col_types[i]})"
    done

    while true; do
        read -p "Enter column number: " col_number

        case $col_number in
            "")
                center "Input cannot be empty."
                ;;
            *[!0-9]*)
                center "Please enter a number."
                ;;
            *)
                if (( col_number < 1 || col_number > ${#col_names[@]} )); then
                    center "Number out of range."
                else
                    break
                fi
                ;;
        esac
    done

    col_index=$col_number
    col_type="${col_types[col_number-1]}"

    while true; do
        read -p "Enter new value: " new_value

        if [[ -z "$new_value" ]]; then
            center "Value cannot be empty."
            continue
        fi

        if [[ "$new_value" == *:* ]]; then
            center "Value cannot contain ':'"
            continue
        fi

        if [[ "$col_type" == "int" ]]; then
            if ! [[ "$new_value" =~ ^-?[0-9]+$ ]]; then
                center "This column requires an integer."
                continue
            fi
        fi

        if (( col_index == 1 )); then
            old_pk=$(echo "$old_row" | cut -d: -f1)

            if [[ "$new_value" != "$old_pk" ]]; then
                if grep -q "^$new_value:" "$data_file_upd"; then
                    center "This primary key already exists. Choose another one."
                    continue
                fi
            fi
        fi

        break
    done

    IFS=':' read -r -a fields <<< "$old_row"
    fields[$((col_index-1))]="$new_value"

    new_row="${fields[0]}"
    for ((i=1; i<${#fields[@]}; i++)); do
        new_row+=":${fields[i]}"
    done

    tmp_file="$data_file_upd.tmp"

    while IFS= read -r line; do
        if [[ "$line" == "$old_row" ]]; then
            echo "$new_row"
        else
            echo "$line"
        fi
    done < "$data_file_upd" > "$tmp_file"

    mv -- "$tmp_file" "$data_file_upd"

    echo ""
    center "Row updated successfully!"
    echo "New row:"
    echo "$new_row"
}
