#!/bin/bash
list_tables() {

    files=("$DB_ROOT/$database_name/"*.SQL)

    if (( ${#files[@]}  ==  0 )) ; then
        center "There are no tables in the database."
        return
    fi

    center "||======== Current Tables ========||"

    for file in "${files[@]}"; do
        name="$(basename "$file")"
        if [[ "$name" == .* ]]; then
           continue
        fi
        center "${name%.SQL}"
    done
    center "||=================================||"
}