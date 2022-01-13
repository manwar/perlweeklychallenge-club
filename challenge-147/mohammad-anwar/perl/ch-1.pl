#!/usr/bin/perl

=head1

Week 147:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-147

Task #1: Truncatable Prime

    Write a script to generate first 20 left-truncatable prime numbers in base 10.

=cut

use strict;
use warnings;
use Test::More;
use Test::Deep;

is_deeply(
    left_truncatable_primes(20),
    [ 2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197 ],
    'Example'
);

done_testing;

#
#
# METHODS

sub left_truncatable_primes {
    my ($count) = @_;

    my $ltp = [];
    my $c   = 0;
    my $n   = 2;
    while ($c < $count) {
        if (($n !~ /0/) && is_prime($n)) {
            my @n = left_truncatable_numbers($n);
            my $found = 1;
            if (@n >= 2) {
                foreach my $_n (@n) {
                    $found = 0 unless (is_prime($_n));
                }
            }
            if ($found) {
                push @$ltp, $n;
                $c++;
            }
        }
        $n++;
    }

    return $ltp;
}

sub left_truncatable_numbers {
    my ($n) = @_;

    my @n = ();
    my $i = 0;
    while ($i < length($n)) {
        push @n, substr($n, $i);
        $i++;
    }

    return @n;
}

sub is_prime {
    my ($n) = @_;

    return 0 if ($n == 1);

    foreach my $i (2 .. sqrt $n) {
        return 0 unless $n % $i
    }

    return 1;
}
