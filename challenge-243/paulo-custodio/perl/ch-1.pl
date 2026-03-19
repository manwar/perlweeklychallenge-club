#!/usr/bin/env perl

# Perl Weekly Challenge 243 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

use Modern::Perl;

@ARGV>0 or die "Usage: ch-1.pl n n ...\n";
say num_reverse_pairs(@ARGV);

sub num_reverse_pairs {
    my(@n) = @_;
    my $count = 0;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            $count++ if $n[$i] > 2* $n[$j];
        }
    }
    return $count;
}
