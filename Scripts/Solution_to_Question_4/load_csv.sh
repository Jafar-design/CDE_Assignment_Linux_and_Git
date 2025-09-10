#!/bin/bash

echo "Executing the env variables"

source ./.env

DB_HOST=$DB_HOST
DB_PORT=$DB_PORT
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD

# I need to tel the script where my files are 
CSV_DIR="/Users/jafarakinfenwa/Documents/CDE_Bootcamp/Scripts/Solution_to_Question_4/csv_files"

# Adding this line for the read permissions to be unlocked in the csv files
chmod 777 csv_files/*.csv

export PGPASSWORD="$DB_PASSWORD"

for csv_file in "$CSV_DIR"/*.csv; do
    table_name=$(basename "$csv_file" .csv) #this extracts the table name from the file name.

    # Adding this line for the read permissions to be unlocked in the csv files

    echo "loading: $csv_file into table: $table_name"

    header=$(head -n 1 "$csv_file")

    # This then takes the csv header and makes it sql table definition
    columns=$(echo "$header" | sed 's/,/ TEXT,/g' | sed 's/"//g')
    columns="$columns TEXT"

    #Adding this part of the code for idempotency. I added it after I encountered an error in the first run if the script

    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "
    DROP TABLE IF EXISTS $table_name;
    CREATE TABLE $table_name ($columns);
    "

    echo "\copy $table_name FROM '$csv_file' DELIMITER ',' CSV HEADER;" | psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME"


    # Error handling
    if [ $? -eq 0 ]; then
            echo "Successfully imported $csv_file to table $table_name"
    else
        echo "Failed to import $csv_file"
    fi

done

echo "Completed imorting the CSVs"



