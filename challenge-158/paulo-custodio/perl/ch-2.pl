#!/usr/bin/env perl

# Challenge 158
#
# TASK #2 › First Series Cuban Primes
# Submitted by: Mohammad S Anwar
# Write a script to compute first series Cuban Primes <= 1000. Please refer
# wikipedia page for more informations.
#
# Output
# 7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919.
#
#     p=(x^3-y^3)/(x-y), x=y+1, y>0
# <=> p=3y^2+3y+1, y>0

use Modern::Perl;
use ntheory qw( is_prime );

say join(", ", cuban_primes(1000));

sub cuban_primes {
    my($limit) = @_;
    my @out;
    my $y = 1;
    my $p;
    do {
        $p = 3*$y*$y+3*$y+1;
        if (is_prime($p)) {
            push @out, $p;
        }
        $y++;
    } while ($p < $limit);
    return @out;
}
