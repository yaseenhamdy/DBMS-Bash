#!/bin/bash

create_Database(){

    center "|| Creating a new database... ||"
    echo ""
    echo "Please Enter Database Name : "
    read database_name

    if [ -z "$database_name" ]
    then
         center "name of database shouldn't be empty"

    elif ! [[ $database_name  =~ $valid_string ]] 
    then
          center "invalid database name" 

    elif [ -d "$DB_ROOT/$database_name" ]
    then
          center "database $database_name already exist"
    else
          mkdir "$DB_ROOT/$database_name"
          center "Databse Created Successfully"          

    fi


}