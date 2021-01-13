#! /usr/bin/perl
use strict;
use warnings;
use feature 'say';
use Algorithm::Combinatorics 'combinations_with_repetition';
use List::Util 'sum';

my @C = sort {$a-$b} (1, 2, 4);
my $S = 6;

my $max = 0 | $S / $C[0];


for my $k (1+$S/$C[-1] .. $max) {
    for my $v ( combinations_with_repetition(\@C, $k) ) {
        ($S == sum @$v) && say "@$v"
    }
}