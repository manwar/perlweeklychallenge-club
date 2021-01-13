#!/usr/bin/perl

#
# Perl Weekly Challenge - 076
#
# Task #1: Prime Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-076
#

use strict;
use warnings;
use Test::More;
use Test::Deep;
use Algorithm::Combinatorics qw(combinations);

is_deeply(prime_sum(find_prime_upto(6), 6),
          [],
          "testing prime sum = 6");
is_deeply(prime_sum(find_prime_upto(9), 9),
          [[2, 7]],
          "testing prime sum = 9");
is_deeply(prime_sum(find_prime_upto(12), 12),
          [[5, 7], [2, 3, 7]],
          "testing prime sum = 12");

done_testing;

#
#
# METHODS

sub prime_sum {
    my ($primes, $sum) = @_;

    my $prime_sum = [];
    foreach my $i (1 .. $sum) {
        last if ($i > @$primes);
        foreach my $comb (combinations($primes, $i)) {
            my $_sum = 0;
            $_sum += $_ for @$comb;
            push @$prime_sum, $comb if ($_sum == $sum);
        }
    }

    return $prime_sum;
}

sub find_prime_upto {
    my ($sum) = @_;

    die "ERROR: Invalid sum [$sum].\n"
        unless (($sum =~ /^\d+$/) && ($sum > 0));

    my $range = { map { $_ => 1 } 2..$sum };
    my $prime = [];

    my $i = 2;
    while (keys %$range) {
        push @$prime, $i;
        ($i, $range) = sieve_of_eratosthenes($i, $range);
        last unless defined $i;
    }

    return $prime;
}

#
#
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

sub sieve_of_eratosthenes {
    my ($i, $range) = @_;

    foreach my $j (sort { $a <=> $b } keys %$range) {
        delete $range->{$j} unless ($j % $i);
    }

    $i  = (sort { $a <=> $b } keys %$range)[0];
    $i += 0 if defined $i;

    return ($i, $range);
}
