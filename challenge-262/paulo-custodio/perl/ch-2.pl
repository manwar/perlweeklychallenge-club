#!/usr/bin/env perl

# Perl Weekly Challenge 262 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/

use Modern::Perl;

my($k, @ints) = @ARGV;
say count_pairs($k, @ints);

sub count_pairs {
    my($k, @ints) = @_;
    my $count = 0;
    for my $i (0 .. $#ints-1) {
        for my $j ($i+1 .. $#ints) {
            $count++ if $ints[$i] == $ints[$j] && ($i*$j) % $k == 0;
        }
    }
    return $count;
}
