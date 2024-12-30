#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum0);

sub hamming_distance{
  sum0 map {sum0 split '',sprintf "%b",$_->[0] ^ $_->[1]}
    combinations($_[0],2)
}

printf "%d\n",hamming_distance([4,14,2]);
printf "%d\n",hamming_distance([4,14,4]);

