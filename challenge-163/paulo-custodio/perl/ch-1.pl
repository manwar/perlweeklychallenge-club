#!/usr/bin/env perl

# Perl Weekly Challenge 163 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

use Modern::Perl;

sub sum_biwise_and {
    my(@n)=@_;
    my $sum=0;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            $sum+=$n[$i]&$n[$j];
        }
    }
    return $sum;
}

say sum_biwise_and(@ARGV);
