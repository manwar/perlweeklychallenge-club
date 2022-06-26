#!/usr/bin/perl

=head1

Week 170:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-170

Task #1: Primorial Numbers

    Write a script to generate first 10 Primorial Numbers.

=cut

use v5.36;
use Test2::V0;
use experimental qw(builtin);
use builtin   qw(true false);

is primorial_numbers(10), [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 ];

done_testing;

#
#
# METHODS

sub is_prime($n) {
    return false if ($n == 1);
    do { return false unless $n % $_ } for (2 .. sqrt $n);
    return true;
}

sub primorial_numbers($n) {
    my @pn = ();
    my $i  = 1;
    my $j  = 1;
    while (@pn < $n) {
        $i++;
        next unless is_prime $i;
        push @pn, $i * $j;
    }

    return \@pn;
}
