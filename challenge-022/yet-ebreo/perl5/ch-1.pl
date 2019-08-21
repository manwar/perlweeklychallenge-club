# Write a script to print first 10 Sexy Prime Pairs.
# Sexy primes are prime numbers that differ from each other by 6.
# For example, the numbers 5 and 11 are both sexy primes, because 11 - 5 = 6.
# The term “sexy prime” is a pun stemming from the Latin word for six: sex.

#This part determines the primes from 0 to 54 using sieve of eratosthenes
#Multiple of each current value (from 0..54) are set to 0 leaving only those
#which are not (Primes)
@_=grep{@_[ map $x*$_,//..@_/($x=$_) ] =0 if $_[$_] > 1}@_=0..54;

#The ocde below go through the primes generated above and print combinations
#which have difference of +6
map { ($_[$_]-$_[$'] == 6) && print "$_[$'] $_[$_]\n" for  $_+//..$#_ } 0..$#_;

#My love for obfuscated code strikes again, sorry ;)
