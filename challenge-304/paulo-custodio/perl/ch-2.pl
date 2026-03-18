#!/usr/bin/env perl

# Perl Weekly Challenge 304 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-304/

use Modern::Perl;
use List::Util qw(sum max);

my @nums = split ' ', <>;
my $n = <>;

say sprintf("%.2f", max_average($n, @nums));

sub max_average {
    my($n, @nums) = @_;
    my $max = -1e10;
    for my $i (0 .. @nums-$n) {
        my $sum = sum(@nums[$i .. $i+$n-1]);
        $max = max($max, $sum);
    }
    return $max/$n;
}
