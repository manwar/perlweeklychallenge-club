#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $input = shift @ARGV;
chomp $input;

# Reject invalid inputs.
die "Invalid input, enter numbers greater than 1.\n" if $input <= 1;

# If it's a prime number then the minimum sum is the number itself.
say $input and exit 0 if is_prime($input) == 1;

if ($input % 2 == 0) {
    # If $input is even then we loop from 2 to `$input / 2' & check if
    # both $i & $diff are primes. If both are primes then we found our
    # numbers!

    # Eventually we'll find 2 primes to be a sum of even numbers. From
    # WikiPedia, https://en.wikipedia.org/wiki/Goldbach%27s_conjecture
    # has been shown to hold for all integers less than `4 × 10^18'.
    foreach my $i (2 ... $input / 2) {
        my $diff = $input - $i;
        say "$i + $diff"
            if is_prime($i) and is_prime($diff);
    }
} elsif (is_prime($input - 2)) {
    # If $input is odd & `$input - 2' is a prime then $input is sum of
    # two primes, 2 & `$input -2'.
    say "2 + $input";
} else {
    # If even that doesn't match then the minimum sum will have three
    # numbers. 3 & then we use the same function as for even numbers
    # to find the other two primes.
    foreach my $i (2 ... ($input - 3) / 2) {
        my $diff = $input - 3 - $i;
        say "3 + $i + $diff"
            if is_prime($i) and is_prime($diff);
    }
}

sub is_prime {
    my $num = shift @_;
    # If $num is divisible by any number between 2 & sqrt($num) then
    # it's not prime. Checking only till
    foreach my $i (2 ... sqrt($num)) {
        return 0 if $num % $i == 0;
    }
    return 1;
}
