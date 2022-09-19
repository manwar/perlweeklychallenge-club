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

is primorial_numbers(10),
   [2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870, 6469693230];

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
    my $i  = 0;
    my $j  = 1;
    while (@pn < $n) {
        $i++;
        next unless is_prime $i;
        $j = $i * $j;
        push @pn, $j;
    }

    return \@pn;
}
