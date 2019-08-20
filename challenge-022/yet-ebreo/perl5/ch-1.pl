# Write a script to print first 10 Sexy Prime Pairs. 
# Sexy primes are prime numbers that differ from each other by 6. 
# For example, the numbers 5 and 11 are both sexy primes, because 11 - 5 = 6. 
# The term “sexy prime” is a pun stemming from the Latin word for six: sex.

@_=grep{@_[ map $x*$_,//..@_/($x=$_) ] =0 if $_[$_] > 1}@_=0..54;
map { ($_[$_]-$_[$'] == 6) && print "$_[$'] $_[$_]\n" for  $_+//..$#_ } 0..$#_;
