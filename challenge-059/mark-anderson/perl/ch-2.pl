#!/usr/bin/env perl

use Modern::Perl;
use Algorithm::Combinatorics 'combinations';

my @list = (2, 3, 4);

my $sum;

for my $ref (combinations(\@list, 2)) {
   $sum += sprintf("%b", $ref->[0] ^ $ref->[1]) =~ tr/1//;
}

say $sum;
