#!/bin/bash
echo 'VERSION 0.0.1'
cd podyn
CONNECTION="jdbc:postgresql://"${POSTGRES_HOST}":"${POSTGRES_PORT}"/"${DATABASE_NAME}"?sslmode=require&user="${DATABASE_USERNAME}"&password="${DATABASE_PASSWORD}""

echo "Starting initial sync for table ${TABLE}"
./podyn --postgres-jdbc-url $CONNECTION --schema --data --table "$TABLE"
wait
echo "Listening for changes for table ${TABLE}"
./podyn --postgres-jdbc-url $CONNECTION --changes --table "$TABLE"