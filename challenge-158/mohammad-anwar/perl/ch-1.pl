#!/usr/bin/perl

=head1

Week 158:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-158

Task #1: Additive Primes

    Write a script to find out all Additive Primes <= 100.

=cut

use strict;
use warnings;
use Test::More;

is_deeply(
    additive_primes(100),
    [ 2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89 ],
    'Example'
);

done_testing;

#
#
# METHODS

sub additive_primes {
    my ($n) = @_;

    my $i  = 1;
    my $ap = [];

    while ($i <= $n) {
        my $s = 0;

        ($i > 10)
        && do { $s += $_ for (split //, $i); };

        (is_prime($i))
        && do { push @$ap, $i if (($s == 0) || is_prime($s)); };

        $i++;
    }

    return $ap;
}

sub is_prime {
    my ($n) = @_;

    return 0 if ($n == 1);

    foreach my $i (2 .. sqrt $n) {
        return 0 unless $n % $i
    }

    return 1;
}
