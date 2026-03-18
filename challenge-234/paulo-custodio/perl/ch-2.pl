#!/usr/bin/env perl

# Perl Weekly Challenge 234 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-234/

use Modern::Perl;

my @nums = @ARGV;
my $count = 0;
for my $i (0 .. $#nums-2) {
    for my $j ($i+1 .. $#nums-1) {
        for my $k ($j+1 .. $#nums) {
            $count++ if $nums[$i] != $nums[$j] &&
                        $nums[$j] != $nums[$k] &&
                        $nums[$k] != $nums[$i];
        }
    }
}
say $count;
