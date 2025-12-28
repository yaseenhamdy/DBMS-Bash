select_from_table() {
    source "./table_func/list_tables.sh"
    source "./table_func/listing_columns.sh"

    clear
    list_tables
    echo ""

    # pick valid table
    while true; do
        read -p "Enter table name: " table_name

        if [[ -z "$table_name" ]]; then
            echo "Table name cannot be empty."
            continue
        fi

        if [[ ! -f "$DB_ROOT/$database_name/$table_name.SQL" || \
              ! -f "$DB_ROOT/$database_name/.$table_name.SQL" ]]; then
            echo "Table does not exist."
            continue
        fi

        break
    done

    meta_file_sel="$DB_ROOT/$database_name/.$table_name.SQL"
    data_file_sel="$DB_ROOT/$database_name/$table_name.SQL"

    # menu loop
    while true; do
        clear
        center "Selected table: $table_name"
        center "+----------------------------+"
        center "| 1 - select specific columns|"
        center "| 2 - Back to Table Menu     |"
        center "+----------------------------+"

        read -p "Choice : " choice

        case $choice in
           
            1)
                list_columns
                echo ""
                echo "Enter column names separated by space (example: name age):"
                read -r cols_input

                if [[ -z "$cols_input" ]]; then
                    echo "You must enter at least one column."
                    read -p "Press Enter to continue..."
                    continue
                fi

                field_list=""
                for col in $cols_input; do
                    idx=$(grep -n "^$col:" "$meta_file_sel" | cut -d: -f1)

                    if [[ -z "$idx" ]]; then
                        echo "Column '$col' does not exist."
                        read -p "Press Enter to continue..."
                        field_list=""
                        break
                    fi

                    if [[ -z "$field_list" ]]; then
                        field_list="$idx"
                    else
                        field_list="$field_list,$idx"
                    fi
                done

                if [[ -z "$field_list" ]]; then
                    continue
                fi

                echo ""
                read -p "Do you want to filter? (y/n): " do_filter

                if [[ "$do_filter" =~ ^[Yy]$ ]]; then
                    list_columns
                    read -p "Enter filter column name: " filter_col

                    filter_idx=$(grep -n "^$filter_col:" "$meta_file_sel" | cut -d: -f1)
                    if [[ -z "$filter_idx" ]]; then
                        echo "Filter column '$filter_col' does not exist."
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
                                print "No records found where filter value = " fval
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
                echo "Invalid choice."
                read -p "Press Enter to continue..."
                ;;
        esac
    done
}
