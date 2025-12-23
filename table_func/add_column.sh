add_column() {
    source "./table_func/list_columns.sh"

    counter_for_adding=1
    isPK=""

    while (( counter_for_adding <= num_of_columns )); do

        clear
        center "Adding Column $counter_for_adding of $num_of_columns"

        if (( counter_for_adding == 1 )); then
            if grep -q ":PK$" "$meta_file"; then
                hasPK=true
            else
                hasPK=false
            fi

            if [[ "$hasPK" == false ]]; then
                isPK=":PK"
            else
                isPK=""
            fi
        else
            isPK=""
        fi

        while true; do
            if ((  counter_for_adding == 1 ))
            then
                echo "Enter column name (PK): "
            else
                echo "Enter column name: "
            fi
                
            read column_name

            if grep -q "^$column_name:" "$meta_file"; then
                center "Column '$column_name' already exists"
                continue
            fi

            if [[ "$column_name" =~ $valid_string ]]; then
                break
            else
                center "Name must start with a letter and contain only letters, digits, or underscores."
            fi
        done

        while true; do
            read -p "Enter column type (1 -> int | 2 -> string): " colomn_type
            case $colomn_type in
                1)
                    column_type_name="int"
                    break
                    ;;
                2)
                    column_type_name="string"
                    break
                    ;;
                *)
                    center "Invalid entry. Must be 1 or 2"
                    ;;
            esac
        done

        echo "$column_name:$column_type_name$isPK" >> "$meta_file"
        list_columns

        (( counter_for_adding++ ))
    done
}
