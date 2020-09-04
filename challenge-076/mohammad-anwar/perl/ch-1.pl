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
use Algorithm::Combinatorics qw(combinations);

my $SUM = $ARGV[0];

print "USAGE: perl $0 <positive_number>\n" and exit unless defined $SUM;
print prime_sum(find_prime_upto($SUM), $SUM);

#
#
# METHODS

sub prime_sum {
    my ($primes, $sum) = @_;

    print sprintf("Primes: %s\n", join(", ", @$primes));
    my $prime_sum = [];
    foreach my $i (1 .. $sum) {
        last if ($i > @$primes);
        foreach my $comb (combinations($primes, $i)) {
            my $_sum = 0;
            $_sum += $_ for @$comb;
            if ($_sum == $sum) {
                if ((@$prime_sum == 0) || (@$prime_sum > @$comb)) {
                    $prime_sum = $comb;
                }
            }

            if (@$prime_sum) {
                return sprintf("Prime Sum: %s\n", join ", ", @$prime_sum);
            }
        }
    }

    return "None found.\n";
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
