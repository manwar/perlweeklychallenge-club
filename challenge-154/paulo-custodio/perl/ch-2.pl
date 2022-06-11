#!/usr/bin/env perl

# Challenge 154
#
# TASK #2 › Padovan Prime
# Submitted by: Mohammad S Anwar
# A Padovan Prime is a Padovan Number that’s also prime.
#
# In number theory, the Padovan sequence is the sequence of integers P(n)
# defined by the initial values.
#
# P(0) = P(1) = P(2) = 1
# and then followed by
#
# P(n) = P(n-2) + P(n-3)
# First few Padovan Numbers are as below:
#
# 1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37, ...
# Write a script to compute first 10 distinct Padovan Primes.
#
# Expected Output
# 2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057

use Modern::Perl;
use Memoize;
use ntheory qw( is_prime );
memoize('padovan');

my $it = uniq_padovan_prime_it();
my @out;
for (1..10) {
    push @out, $it->();
}
say join(", ", @out);

sub uniq_padovan_prime_it {
    my $padovan_prime_it = padovan_prime_iter();
    my %got;
    return sub {
        while (1) {
            my $got = $padovan_prime_it->();
            if (!$got{$got}) {
                $got{$got} = 1;
                return $got;
            }
        }
    };
}

sub padovan_prime_iter {
    my $padovan_it = padovan_iter();
    return sub {
        while (1) {
            my $got = $padovan_it->();
            if (is_prime($got)) {
                return $got;
            }
        }
    };
}

sub padovan_iter {
    my $n = 0;
    return sub {
        $n++;
        return padovan($n);
    };
}

sub padovan {
    my($n) = @_;
    if ($n < 3) {
        return 1;
    }
    else {
        return padovan($n-2) + padovan($n-3);
    }
}
