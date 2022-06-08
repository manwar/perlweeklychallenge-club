#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

# Task 2: Home Prime
# Submitted by: Mohammad S Anwar
# You are given an integer greater than 1.

# Write a script to find the home prime of the given number.

# In number theory, the home prime HP(n) of an integer n greater than 1 is the prime number obtained by repeatedly factoring the increasing concatenation of prime factors including repetitions.

# Further information can be found on Wikipedia and OEIS.

# Example
# As given in the Wikipedia page,

# HP(10) = 773, as 10 factors as 2×5 yielding HP10(1) = 25, 25 factors as 5×5 yielding HP10(2) = HP25(1) = 55, 55 = 5×11 implies HP10(3) = HP25(2) = HP55(1) = 511, and 511 = 7×73 gives HP10(4) = HP25(3) = HP55(2) = HP511(1) = 773, a prime number.

# written with github copilot

# calculate the prime factors of a number
sub prime_factors {
    my $n = shift;
    my @factors = ();
    my $i = 2;
    while ($n > 1) {
        while ($n % $i == 0) {
            push @factors, $i;
            $n /= $i;
        }
        $i++;
    }
    return @factors;
}

sub is_prime {
    my $n = shift;
    return 0 if $n < 2;
    return 1 if $n == 2;
    return 0 if $n % 2 == 0;
    for (my $i = 3; $i <= sqrt($n); $i += 2) {
        return 0 if $n % $i == 0;
    }
    return 1;
}

# calculate the home prime of a number
# In number theory, the home prime HP(n) of an integer n greater than 1 is the prime number obtained by repeatedly factoring the increasing concatenation of prime factors including repetitions.
sub home_prime {
    my $n = shift;

    return $n if is_prime($n);
    return home_prime(join '', prime_factors($n));
}

# a version of home_prime that produces debug output at every step
sub home_prime_debug {
    my $n = shift;

    say "n = $n";
    return $n if is_prime($n);
    my @factors = prime_factors($n);
    say "factors = @factors";
    return home_prime_debug(join '', @factors);
}

__END__

use Test::More;
is_deeply [prime_factors(10)], [2, 5];
is_deeply [prime_factors(13)], [13];
is_deeply [prime_factors(14)], [2, 7];

is home_prime(10), 773;
is home_prime_debug(10), 773;
done_testing;