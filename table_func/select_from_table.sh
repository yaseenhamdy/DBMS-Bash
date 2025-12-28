select_from_table() {
    source "./table_func/list_tables.sh"
    source "./table_func/listing_columns.sh"

    clear
    list_tables
    echo ""

    while true; do
        read -p "Enter table name: " table_name

        if [[ -z "$table_name" ]]; then
            center "Table name cannot be empty."
            continue
        fi

        if [[ ! -f "$DB_ROOT/$database_name/$table_name.SQL" || \
              ! -f "$DB_ROOT/$database_name/.$table_name.SQL" ]]; then
            center "Table does not exist."
            continue
        fi

        break
    done

    meta_file_sel="$DB_ROOT/$database_name/.$table_name.SQL"
    data_file_sel="$DB_ROOT/$database_name/$table_name.SQL"

    if [[ ! -s "$meta_file_sel" ]]; then
        center "Table '$table_name' has no columns. Nothing to select."
        read -p "Press Enter to continue..."
        table_main_menu
    fi

    if [[ ! -s "$data_file_sel" ]]; then
        center "Table '$table_name' is empty. No data to select."
        read -p "Press Enter to continue..."
        table_main_menu
    fi

    while true; do
        clear
        center "Selected table: $table_name"
        center "+----------------------------+"
        center "| 1 - Select specific columns|"
        center "| 2 - Back to Table Menu     |"
        center "+----------------------------+"

        read -p "Choice : " choice

        case $choice in
            1)
                list_columns
                echo ""
                read -p "Enter column names separated by space (example: name age): " cols_input

                if [[ -z "$cols_input" ]]; then
                    center "You must enter at least one column."
                    read -p "Press Enter to continue..."
                    continue
                fi

                field_list=""
                invalid_col=0

                for col in $cols_input; do
                    idx=$(grep -n "^$col:" "$meta_file_sel" | cut -d: -f1)

                    if [[ -z "$idx" ]]; then
                        center "Column '$col' does not exist."
                        invalid_col=1
                        break
                    fi

                    if [[ -z "$field_list" ]]; then
                        field_list="$idx"
                    else
                        field_list="$field_list,$idx"
                    fi
                done

                if (( invalid_col == 1 )); then
                    read -p "Press Enter to continue..."
                    continue
                fi

                echo ""
                read -p "Do you want to filter? (y/n): " do_filter

                if [[ "$do_filter" =~ ^[Yy]$ ]]; then
                    list_columns
                    read -p "Enter filter column name: " filter_col

                    filter_idx=$(grep -n "^$filter_col:" "$meta_file_sel" | cut -d: -f1)
                    if [[ -z "$filter_idx" ]]; then
                        center "Filter column '$filter_col' does not exist."
                        read -p "Press Enter to continue..."
                        continue
                    fi

                    read -p "Enter filter value for $filter_col: " filter_val

                    awk -F':' -v fields="$field_list" -v fcol="$filter_idx" -v fval="$filter_val" '
                        BEGIN {
                            n = split(fields, f, ",")
                            found = 0
                        }
                        $fcol == fval {
                            found = 1
                            for (i = 1; i <= n; i++) {
                                printf "%s", $f[i]
                                if (i < n) printf ":"
                            }
                            printf "\n"
                        }
                        END {
                            if (found == 0)
                                print "No records found where " fcol " = " fval
                        }
                    ' "$data_file_sel"
                else
                    awk -F':' -v fields="$field_list" '
                        BEGIN { n = split(fields, f, ",") }
                        {
                            for (i = 1; i <= n; i++) {
                                printf "%s", $f[i]
                                if (i < n) printf ":"
                            }
                            printf "\n"
                        }
                    ' "$data_file_sel"
                fi

                read -p "Press Enter to continue..."
                ;;

            2)
                return
                ;;

            *)
                center "Invalid choice."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
}
