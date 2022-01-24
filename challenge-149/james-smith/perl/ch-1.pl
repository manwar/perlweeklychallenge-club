#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

# As an array we don't need to keep the fibonacci numbers
# We need them as the keys to the hash %fib which we use
# to check that a digit sum is a fibonacci number. Instead
# We only keep the last two values $fa & $fb
for( my($n,$ds,$i,$fa,$fb,%fib)=(@ARGV?$ARGV[0]:20,0,0,1,1,0,1,1,1);
     $n; $i++,$ds=0 ) {
  $ds+=$_ foreach split //,$i;
      ## If we dont have a large enough fib add the next one...
      ## Digit sum can only be 1 larger than current maximum
      ## fibonacci.
  ($fib{$fa+$fb},$fa,$fb)=(1,$fb,$fa+$fb) if $ds > $fb;
  $n--,say $i if exists $fib{$ds};
}

