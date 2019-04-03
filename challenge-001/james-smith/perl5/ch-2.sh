perl -E 'say "".($_%3?"":"Fizz").($_%5?"":"Buzz")||$_ for 1..20;'
