#!/usr/bin/env perl

# Perl Weekly Challenge 233 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-233/

use Modern::Perl;

my @ints = @ARGV;
my %count;
for (@ints) {
    $count{$_}++;
}
say "(", join(", ",
    map {$_->[0]}
    sort {$a->[1] == $b->[1] ? $b->[0] <=> $a->[0] : $a->[1] <=> $b->[1]}
    map {[$_, $count{$_}]} @ints), ")";
