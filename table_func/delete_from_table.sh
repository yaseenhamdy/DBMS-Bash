delete_from_table() {
    clear
    source "./table_func/list_tables.sh"
    list_tables


    meta_del="$DB_ROOT/$database_name/.$tableName.SQL"
    data_del="$DB_ROOT/$database_name/$tableName.SQL"

    while true; do
    read -p "Enter table name: " tableName

    meta_del="$DB_ROOT/$database_name/.$tableName.SQL"
    data_del="$DB_ROOT/$database_name/$tableName.SQL"

    if [[ -f "$meta_del" && -f "$data_del" ]]; then
        break   
    else
        echo "Table does not exist, try again"
    fi
done

    center "||======== Current data ========||"
    while IFS= read -r line; do
        center "$line"
    done < "$data_del"
    center "||=================================||"

    columns=()
    types=()

    while IFS=: read -r col type; do
        columns+=("$col")
        types+=("$type")
    done < "$meta_del"

    pk="${columns[0]}"
    pk_type="${types[0]}"

    echo "Choose delete option:"
    select option in "Delete by Primary Key" "Delete by Any Column" "Delete All Data"; do
        case $REPLY in
            1)
                read -p "Enter $pk value: " value

                if [[ "$pk_type" == "int" ]]; then
                    [[ "$value" =~ ^[0-9]+$ ]] || { echo "Must be integer"; continue; }
                else
                    [[ "$value" =~ ^[a-zA-Z0-9]+$ ]] || { echo "Must be string"; continue; }
                fi

                awk -F':' -v v="$value" '
                    BEGIN {c=0}
                    $1 == v { c++; next }
                    { print }
                    END { print c > "/tmp/counter" }
                ' "$data_del" > tmp && mv tmp "$data_del"

                count=$(cat /tmp/counter)
                if [[ "$count" -eq 0 ]]; then
                    echo "No rows satisfy this value"
                else
                    echo "$count record(s) deleted"
                fi

                read -p "Press Enter to continue..."
                break
                ;;

            2)
                echo "Choose column:"
                select col in "${columns[@]}"; do
                    col_index=$((REPLY - 1))
                    col_name="${columns[$col_index]}"
                    col_type="${types[$col_index]}"

                    [[ -n "$col_name" ]] || { echo "Invalid column"; continue; }

                    read -p "Enter value for $col_name: " value

                    if [[ "$col_type" == "int" ]]; then
                        [[ "$value" =~ ^[0-9]+$ ]] || { echo "Must be integer"; break; }
                    else
                        [[ "$value" =~ ^[a-zA-Z0-9]+$ ]] || { echo "Must be string"; break; }
                    fi

                    awk -F':' -v col=$((col_index+1)) -v v="$value" '
                        BEGIN {c=0}
                        $col == v { c++; next }
                        { print }
                        END { print c > "/tmp/final_count" }
                    ' "$data_del" > tmp && mv tmp "$data_del"

                    counter=$(cat /tmp/final_count)
                    if [[ "$counter" -eq 0 ]]; then
                        echo "No rows satisfy this condition"
                    else
                        echo "$counter record(s) deleted where $col_name = $value"
                    fi

                    read -p "Press Enter to continue..."
                    break 2
                done
                ;;

            3)
                > "$data_del"
                echo "All data deleted"
                read -p "Press Enter to continue..."
                break
                ;;

            *)
                echo "Invalid choice"
                read -p "Press Enter to continue..."
                ;;
        esac
    done
}
