#!/usr/bin/env perl

# Perl Weekly Challenge 228 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-228/

use Modern::Perl;
use List::Util 'sum';

my @ints = @ARGV;
my %count;
for (@ints) {
    $count{$_}++;
}
my $sum = sum(map {$_->[0]} grep {$count{$_->[0]}==1} map {[$_, $count{$_}]} @ints)//0;
say $sum;
