#!/usr/bin/env perl

use Modern::Perl '2018';
use List::Util 'all';

# Find the longest common substring.

my @strings = @ARGV;
my $pattern = pop @strings;
my $longest;

OUTER:
for(my $w=length $pattern; $w>0; $w--) {
    for(my $i=0; $i<=(length $pattern)-$w; $i++) {
        $longest = substr $pattern, $i, $w;
            last OUTER if all { /$longest/ } @strings;
    }
}

say $longest;
