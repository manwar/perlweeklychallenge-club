#!/bin/sh

for i in $*; do
    psql  -At -h miguel -U luca -c "SELECT pg_sleep( $i ); SELECT $i;"  testdb &
done

echo 
