#!/usr/bin/env perl

# Perl Weekly Challenge 283 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/

use Modern::Perl;

my @ints = @ARGV;
my %count;
for (@ints) {
    $count{$_}++;
}
my($unique) = map {$_->[0]} grep {$count{$_->[0]}==1} map {[$_, $count{$_}]} @ints;
say $unique;
