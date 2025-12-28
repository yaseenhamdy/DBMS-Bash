
table_main_menu(){
source "./table_func/create_table.sh"
source "./table_func/drop_table.sh"
source "./table_func/list_tables.sh"
source "./table_func/insert_into_table.sh"
source "./table_func/select_from_table.sh"
source "./table_func/update_table.sh"
source "./table_func/delete_from_table.sh"

while true;
do

clear

tput setaf 2
        center "|== Connected to DataBase ==|"
        center "==========================================="
        center "||         Table Management Menu         ||"
        center "==========================================="
        echo ""
        center "Please select an option:"
        echo ""
        center ":.:.:.:.: Table Menu :.:.:.:.:"
        center "|                            |"
        center "|    1. Create Table         |"
        center "|    2. Update Table Meta    |"
        center "|    3. List Tables          |"
        center "|    4. Drop Table           |"
        center "|    5. Insert into Table    |"
        center "|    6. Select from Table    |"
        center "|    7. Update Table Data    |"
        center "|    8. Delete from Table    |"
        center "|    9. Back to Main Menu    |"
        center "|                            |"
        center "=============================="
        echo "" 
tput setaf 4
echo -n "$(tput setaf 3)Choice : "
read choice
case $choice in
    1) create_table
       read -p "Press Enter to continue..." 
       ;;
    2) exit
       ;;
    3) list_tables
       read -p "Press Enter to continue..." 
       ;;
    4) drop_table
       read -p "Press Enter to continue..." 
       ;;
    5) insert_into_table
       read -p "Press Enter to continue..." 
       ;;
   6)  select_from_table   
       read -p "Press Enter to continue..."
       ;;
   7)  update_table
       read -p "Press Enter to continue..."
       ;;
   8) delete_from_table
       ;;
   9) main
       ;;
    *) center "Invalid choice, please try again."
            echo "" 
            read -p "Press Enter to continue..."
            ;;

esac
done
}