#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

# Task 1: Perrin Prime
# Submitted by: Roger Bell_West
# The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)

# A Perrin prime is a number in the Perrin sequence which is also a prime number.

# Calculate the first 13 Perrin Primes.

# f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]

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

sub perrin_primes {
    my $n = shift;
    my %primes = map { $_ => 1 } 2, 3;
    my @perrin = (3, 0, 2);
    my $i = 3;
    while (keys %primes < $n) {
        $perrin[$i] = $perrin[$i - 2] + $perrin[$i - 3];
        if (is_prime($perrin[$i])) {
            $primes{$perrin[$i]} = 1;
        }
        $i++;
    }
    return sort { $a <=> $b } keys %primes;
}

my @primes = perrin_primes(13);
say "@primes";

__END__
use Test::More;
is_deeply \@primes, [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977];
done_testing;