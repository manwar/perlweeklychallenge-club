#!/usr/bin/env perl

# Perl Weekly Challenge 014-1
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/

# Write a script to generate Van Eck's sequence starting with 0. For
# more information, please check out wikipedia page at
# https://en.wikipedia.org/wiki/Van_Eck%27s_sequence

use strict;
use warnings;
use feature 'say';

my $N = shift @ARGV || 10;
my @vals;
my $next = 0;

for my $n (0..$N) {
    push @vals, $next;

    # have we seen it before?
    $next = 0;
    for (my $i = $n-1; $i >= 0; $i--) {
        if ($vals[$i] == $vals[$n]) {
            $next = $n - $i;
            last;
        }
    }
}

say join ", ", @vals;
