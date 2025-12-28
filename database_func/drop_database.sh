
drop_database() {
    clear
    source "./database_func/list_database.sh"
    

 center "||======== Current databases ========||"

   list_database

center "||====================================||"


    read -p "Enter database name to drop: " dbName

    db_path="$DB_ROOT/$dbName"

    if [ -d "$db_path" ]; then
        rm -r "$db_path"
        center "Database '$dbName' dropped successfully."
    else
        center "Database '$dbName' does not exist."
    fi

}