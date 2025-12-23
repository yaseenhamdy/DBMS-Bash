#!/bin/bash

list_database(){

    counter=1

    databases=("$DB_ROOT/"*)

   if [ "${#databases[@]}" -eq 0 ]
    then
         center "There is No Databases"
    else
         for database in  "${databases[@]}"
           do
             center "$counter"-$(basename "$database")
             (( counter++ ))
           done
    fi   
 

}