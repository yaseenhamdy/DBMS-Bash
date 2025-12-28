select_from_table() {
    source "./table_func/list_tables.sh"
    source "./table_func/table_menu.sh"
    source "./table_func/listing_columns.sh"

    clear
    list_tables
    echo ""

    while true; do
        read -p "Enter table name: " table_name

        if [[ -z "$table_name" ]]; then
            echo "Table name cannot be empty."
            continue
        fi

        if [[ ! -f "$DB_ROOT/$database_name/$table_name.SQL" || ! -f "$DB_ROOT/$database_name/.$table_name.SQL" ]]; then
            echo "Table does not exist."
            continue
        fi

        break
    done

    while true; do
        clear
        center "Selected table: $table_name"
        center "+---------------------------+"
        center "| 1 - select all table      |"
        center "| 2 - select specific row   |"
        center "| 3 - select specific column|"
        center "| 4 - Back to Table Menu    |"
        center "+---------------------------+"

        read -p "Choice : " choice

        case $choice in
            1)
                cat "$DB_ROOT/$database_name/$table_name.SQL"
                read -p "Press Enter to continue..."
                ;;
            2)
                read -p "Enter primary key value: " pk_value
                if grep -q "^$pk_value:" "$DB_ROOT/$database_name/$table_name.SQL"; then
                    grep "^$pk_value:" "$DB_ROOT/$database_name/$table_name.SQL"
                else
                    echo "No row found with primary key value: $pk_value"
                fi
                read -p "Press Enter to continue..."
                ;;
            3)
                list_columns

                read -p "Enter column name: " col_name


                if grep -q "^$col_name:" "$DB_ROOT/$database_name/.$table_name.SQL"; then
                    col_index=$(grep -n "^$col_name:" "$DB_ROOT/$database_name/.$table_name.SQL" | cut -d: -f1)
                    cut -d: -f"$col_index" "$DB_ROOT/$database_name/$table_name.SQL"
                else
                    echo "Column $col_name does not exist in table $table_name"
                fi
                read -p "Press Enter to continue..."
                ;;
            4)
                table_main_menu
                ;;
            *)
                echo "Invalid choice."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
}
