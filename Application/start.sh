#!/bin/bash

# Create the init.sql file at the $HOME/init.sql path and write information to the file
echo "-- init.sql" > $HOME/init.sql
echo "CREATE DATABASE test;" >> $HOME/init.sql

# Run the MySQL container with the init.sql file mounted
docker run -d --name mysqlsrv1 -e MYSQL_ROOT_PASSWORD=a123456 -e MYSQL_ROOT_HOST=% -p 3306:3306 -v $HOME/init.sql:/docker-entrypoint-initdb.d/init.sql mysql

# Run the Django container
docker run -d -p 8000:8000 trourest186/django-project
