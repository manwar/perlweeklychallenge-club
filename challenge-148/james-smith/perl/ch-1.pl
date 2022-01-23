#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

## Units for which there are no "e" are used:
##   0 [ not-spelled at all except for Zero ]
##   2 two
##   4 four
##   6 six
## Tens for which there a no "e":
##   0 [ not-spelled at all except for Zero ]
##  30 thirty
##  40 forty
##  50 fifty
##  60 sixty
## We only need to find 2 digit eban numbers here as there are no 3
## digit eban numbers - hundred contains an "e"...

unless(@ARGV) {
  ## All eban numbers less than 1000
  say for map{my$a=$_;map{10*$a+2*$_||()}(0..3)}(0,3..6);
  exit;
}

## This is the code which generates eban numbers {up to 10^18}

say for my@e=grep{$_}my@n=map{my$a=$_;map{10*$a+2*$_}(0..3)}(0,3..6);
for(2..$ARGV[0]){
  say for@e=map{my$a=$_;map{$a*1e3+$_}@n}@e;
}

## works for $N up to 7 (numbers up to but not including 1 sextillion)
## There are no additional numbers for $N = 8 and 9.
## Then we have additional numbers for $N = 10 and 11.
## And then no eban numbers until we get to $N = 22
## So we need to some more complex code to work from $N=10 onwards
## as we have no solutions for numbers containing sextillion, septillion
## decillion to novemdecillion ..


########################################################################
## Now we extend these by adding more digits at the end so we get those
## less than 1 million, 1 billion etc.
## Note there would need to be a slight tweak when we get to sextillion,
## septillion to skip those numbers

########################################################################
## Just as an aside the number of eban numbers for $N is precisely
##    20^$N - 1 (up to including $N==7)
## The -1 is that the 20^$N includes the number 0 (which a isn't
## positive but contains a zero anyway if you call it "zero")
## There is an imprecise nature to this list as the definition does not
## specify where eban numbers can be negative - if this is the case any
## +ve eban number has an associated -ve eban number - and visa-versa.

