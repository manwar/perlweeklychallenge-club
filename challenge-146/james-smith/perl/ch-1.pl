#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my @primes = (2);

for( my $c=3; @primes<10001; $c+=2 ) {
  ($_>sqrt$c)?((push@primes,$c),last):$c%$_||last for @primes;
}

say $primes[-1];
