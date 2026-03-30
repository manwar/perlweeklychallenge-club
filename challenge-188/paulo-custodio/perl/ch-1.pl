#!/usr/bin/env perl

# Perl Weekly Challenge 188 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-188/

use Modern::Perl;

sub divisible_pairs {
    my(@n)=@_;
    my $k=pop @n;
    my $count=0;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            if (($n[$i]+$n[$j])%$k==0) {
                $count++;
            }
        }
    }
    return $count;
}

say divisible_pairs(@ARGV);
