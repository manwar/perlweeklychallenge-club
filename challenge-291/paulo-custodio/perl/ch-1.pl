#!/usr/bin/env perl

# Perl Weekly Challenge 291 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-291/

use Modern::Perl;
use List::Util 'sum0';

sub middle_index {
    my(@n) = @_;
    for my $i (0 .. $#n) {
        my $s1 = sum0(@n[0..$i-1]);
        my $s2 = sum0(@n[$i+1..$#n]);
        return $i if $s1 == $s2;
    }
    return -1;
}

say middle_index(@ARGV);
