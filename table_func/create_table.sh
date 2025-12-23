create_table(){

    echo "Enter table name : "
    read table_name

    meta_file="$DB_ROOT/$database_name/$table_name".meta
    data_file="$DB_ROOT/$database_name/$table_name".data

    if [[ -e "$meta_file" || -e "$data_file" ]]
    then
         center "Table already exist"
    elif ! [[ $table_name =~ $valid_string ]]
    then
         center "Invalid Table Name"
    else 
         touch "$meta_file" "$data_file"
         echo "Enter Number of coulmns : "
         read num_of_columns

         if ! [[ $num_of_columns =~ $valid_number ]]
         then
              center "Only Number is vaild"
         elif (( num_of_columns <= 0 ))
         then 
             center "number of columns must be greater than 0"
         else  

    source "./table_func/list_columns.sh"

list_columns.sh
             source "./table_func/add_column.sh"
             add_column   


         fi         

    fi 

}