#!/usr/bin/env perl

# Perl Weekly Challenge 225 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-225/

use Modern::Perl;

my @ints = @ARGV;
my @sum = right_sum_diff(@ints);
say "(", join(", ", @sum), ")";

sub right_sum_diff {
    my(@ints) = @_;

    my $sum = 0;
    my @left = ($sum);
    for (@ints[0..$#ints-1]) {
        $sum += $_;
        push @left, $sum;
    }

    $sum = 0;
    my @right = ($sum);
    for (reverse @ints[1..$#ints]) {
        $sum += $_;
        unshift @right, $sum;
    }

    my @sum;
    for (0..$#ints) {
        push @sum, abs($left[$_]-$right[$_]);
    }
    return @sum;
}
