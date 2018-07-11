#!/bin/bash
echo 'VERSION 0.0.2'
cd podyn
CONNECTION="jdbc:postgresql://"${POSTGRES_HOST}":"${POSTGRES_PORT}"/"${DATABASE_NAME}"?sslmode=require&user="${DATABASE_USERNAME}"&password="${DATABASE_PASSWORD}""

if [ -n "${CONVERT_NUMBERS_TO_TEXT}" ]; then
    echo "Converting number fields to text"
    echo "Starting initial sync for table ${TABLE}"
    ./podyn --postgres-jdbc-url $CONNECTION --schema --data --convert-numbers-to-text --table "$TABLE" 
    wait
    echo "Listening for changes for table ${TABLE}"
    ./podyn --postgres-jdbc-url $CONNECTION --changes --convert-numbers-to-text --table "$TABLE" 
else 
    echo "Starting initial sync for table ${TABLE}"
    ./podyn --postgres-jdbc-url $CONNECTION --schema --data --table "$TABLE" 
    wait
    echo "Listening for changes for table ${TABLE}"
    ./podyn --postgres-jdbc-url $CONNECTION --changes --table "$TABLE" 
fi