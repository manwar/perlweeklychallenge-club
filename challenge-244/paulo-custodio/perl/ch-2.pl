#!/usr/bin/env perl

# Perl Weekly Challenge 244 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

use Modern::Perl;
use List::Util qw( min max );
use Math::Combinatorics;

@ARGV or die "Usage: $0 n n n...\n";

sub calc_power {
    my(@n) = @_;
    return (max(@n)**2) * min(@n);
}

sub power {
    my(@n) = @_;
    my $sum = 0;
    for my $k (1 .. @n) {
        my $combinat = Math::Combinatorics->new(count => $k,
                                                data => [@n]);
        while(my @combo = $combinat->next_combination){
            $sum += calc_power(@combo);
        }
    }
    return $sum;
}

say power(@ARGV);
