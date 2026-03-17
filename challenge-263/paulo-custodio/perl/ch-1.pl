#!/usr/bin/env perl

# Perl Weekly Challenge 263 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

use Modern::Perl;

my($k, @ints) = @ARGV;
@ints = sort {$a <=> $b} @ints;
my @idx =
        map {$_->[0]}
        grep {$_->[1] == $k}
        map {[$_, $ints[$_]]} 0 .. $#ints;
say "(", join(", ", @idx), ")";
