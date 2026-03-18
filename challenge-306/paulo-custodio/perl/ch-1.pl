#!/usr/bin/env perl

# Perl Weekly Challenge 306 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-306/

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
say sum_odds(@ARGV);

sub sum_odds {
    my(@nums) = @_;
    my $sum = 0;
    for (my $len = 1; $len <= @nums; $len += 2) {
        for my $i (0 .. $#nums) {
            next if $i + $len > @nums;
            $sum += sum(@nums[$i .. $i + $len - 1]);
        }
    }
    return $sum;
}
