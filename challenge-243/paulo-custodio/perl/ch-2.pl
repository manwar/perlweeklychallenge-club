#!/usr/bin/env perl

# Perl Weekly Challenge 243 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

use Modern::Perl;

@ARGV>0 or die "Usage: ch-2.pl n n ...\n";
say sum_floor(@ARGV);

sub sum_floor {
    my(@n) = @_;
    my $sum = 0;
    for my $i (0..$#n) {
        for my $j (0..$#n) {
            $sum += int($n[$i] / $n[$j]);
        }
    }
    return $sum;
}
