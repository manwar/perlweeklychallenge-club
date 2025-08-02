#!/usr/bin/env perl

# Challenge 168
#
# Task 2: Home Prime
# Submitted by: Mohammad S Anwar
#
# You are given an integer greater than 1.
#
# Write a script to find the home prime of the given number.
#
# In number theory, the home prime HP(n) of an integer n greater than 1 is the
# prime number obtained by repeatedly factoring the increasing concatenation of
# prime factors including repetitions.
#
# Further information can be found on Wikipedia and OEIS.
# Example
#
# As given in the Wikipedia page,
#
# HP(10) = 773, as 10 factors as 2x5 yielding HP10(1) = 25, 25 factors as 5x5
# yielding HP10(2) = HP25(1) = 55, 55 = 5x11 implies HP10(3) = HP25(2) = HP55(1)
# = 511, and 511 = 7x73 gives HP10(4) = HP25(3) = HP55(2) = HP511(1) = 773, a
# prime number.

use Modern::Perl;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}

sub prime_factors {
    my($n) = @_;
    my @factors;
    my $p = 0;
    while ($n > 1) {
        do { $p++; } while (!is_prime($p));
        while ($n % $p == 0) {
            push @factors, $p;
            $n /= $p;
        }
    }
    return @factors;
}

sub home_prime {
    my($n) = @_;
    die unless $n > 1;
    while (!is_prime($n)) {
        my @factors = prime_factors($n);
        $n = 0+join '', @factors;
    }
    return $n;
}


@ARGV==1 or die "usage: ch-1.pl n\n";
say home_prime(shift);
