#!/usr/bin/env perl

# Perl Weekly Challenge 271 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-271/

use Modern::Perl;

my @n = @ARGV;

say "(", join(", ",
        map {$_->[0]}
        sort {$a->[1] != $b->[1] ? $a->[1] <=> $b->[1] : $a->[0] <=> $b->[0]}
        map {[$n[$_], sprintf("%b", $n[$_]) =~ tr/1/1/]} 0 .. $#n), ")";
