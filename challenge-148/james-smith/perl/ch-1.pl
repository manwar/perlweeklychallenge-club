#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $N = @ARGV ? $ARGV[0] : 1;

## works for $N up to 7 (numbers up to but not including 1 sextillion)
## There are no additional numbers for $N = 8 and 9.
## Then we have additional numbers for $N = 10 and 11.
## And then no eban numbers until we get to $N = 22
## So we need to some more complex code to work from $N=10 onwards
## as we have no solutions for numbers containing sextillion, septillion
## decillion to novemdecillion ..

my @digits = (0,2,4,6);
my @tens   = (0,30,40,50,60);

## We only need to find 2 digit eban numbers here as there are no 3
## digit eban numbers - hundred contains an "e"...

## We need to dump our first eban numbers!

dump_list(my@eb=grep{$_}my@nx=map{my$a=$_;map{$a+$_}@digits}@tens);

########################################################################
## Now we extend these by adding more digits at the end so we get those
## less than 1 million, 1 billion etc.
## Note there would need to be a slight tweak when we get to sextillion,
## septillion to skip those numbers

dump_list(@eb=map{my$a=$_;map{sprintf'%s,%03d',$a,$_}@nx}@eb)for 2..$N;

########################################################################
## Just as an aside the number of eban numbers for $N is precisely
##    20^$N - 1 (up to including $N==7)
## The -1 is that the 20^$N includes the number 0 (which a isn't
## positive but contains a zero anyway if you call it "zero")
## There is an imprecise nature to this list as the definition does not
## specify where eban numbers can be negative - if this is the case any
## +ve eban number has an associated -ve eban number - and visa-versa.

## In dump_list below we remove leading zeros and blank entries
## To avoid grep - we check to see if $_ is "non-zero"
## and if it is we add an empty array element rather
## than blank. This avoids the additional map, and potential double
## array calculation

sub dump_list {
  say for map { $_ ? s{^0+}{}r : () }  @_;
}
