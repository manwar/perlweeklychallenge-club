#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my @primes = (3);

for( my $c=5; @primes<10000; $c+=2 ) {
  ($_*$_>$c)?((push@primes,$c),last):$c%$_||last for @primes;
}

say $primes[-1];
