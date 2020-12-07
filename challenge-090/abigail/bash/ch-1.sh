#/bin/sh

#
# For challenge, see ../perl/ch-1.pl
#

while read DNA
do echo "$DNA\c" | wc -c | sed -e 's/ *//'
   echo  $DNA    | tr ATCG TAGC
done
