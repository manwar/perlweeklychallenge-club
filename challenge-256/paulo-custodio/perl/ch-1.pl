#!/usr/bin/env perl

# Perl Weekly Challenge 256 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/

use Modern::Perl;

my @words = @ARGV;
my $count = 0;
for my $i (0 .. $#words-1) {
    for my $j ($i+1 .. $#words) {
        $count++ if is_pair($words[$i], $words[$j]);
    }
}
say $count;


sub is_pair {
    my($a, $b) = @_;
    return $a eq join '', reverse split //, $b;
}
