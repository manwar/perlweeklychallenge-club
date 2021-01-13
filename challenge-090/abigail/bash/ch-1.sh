#/bin/sh

while read DNA
do echo "$DNA\c" | wc -c | sed -e 's/ *//'
   echo  $DNA    | tr ATCG TAGC
done
