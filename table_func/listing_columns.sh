list_columns(){
    counter=1
    clear
    center "||======== Current Columns ========||"

    meta_file="$DB_ROOT/$database_name/$table_name".meta
    names_of_columns=() 

for column in $(cat "$meta_file"); do
        col_name=$(echo "$column" | cut -d':' -f1)
        names_of_columns+=("$col_name")
    done

for column in "${names_of_columns[@]}"
do
    center "$counter-$column"
    (( counter++ ))
done

    center "||=================================||"
}