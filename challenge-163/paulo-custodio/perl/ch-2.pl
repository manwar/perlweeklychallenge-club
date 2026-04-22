#!/usr/bin/env perl

# Perl Weekly Challenge 163 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

use Modern::Perl;
use List::Util 'sum';

sub summation {
    my(@n)=@_;
    while (@n>1) {
        shift @n;
        my @m;
        for my $i (0..$#n) {
            $m[$i]=sum(@n[0..$i]);
        }
        @n=@m;
    }
    return shift @n;
}

say summation(@ARGV);
