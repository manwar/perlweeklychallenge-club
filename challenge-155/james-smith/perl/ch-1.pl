#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(next_prime);

my %res;

for( my $p = my $pp = 2;
     $pp < 1<<63;
     $pp *= $p = next_prime($p)
) {
  $res{ next_prime($pp+2) - $pp } = 1;
}

say for sort { $a <=> $b } keys %res;
