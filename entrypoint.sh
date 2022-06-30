#!/bin/bash

python3 print("Hello world1")

python3 manage.py makemigrations
python3 manage.py migrate

if [ "$POSTGRES_DB" = "netflix" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi


exec "$@"

gunicorn netflix.wsgi:application --bind 68.183.201.244:8000

