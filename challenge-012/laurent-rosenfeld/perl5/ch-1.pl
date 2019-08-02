#!/usr/bin/perl
use strict;
use warnings;
use feature "say";
use constant largest_num => 1000;

sub find_primes {
    my $num = 3;
    my @primes = (2, 3);
    while (1) {
        $num += 2;     # check only odd numbers
        last if $num > largest_num;
        my $limit = int $num ** 0.5;
        my $num_is_prime = 1;
        for my $prime (@primes) {
            last if $prime > $limit;
            if ($num % $prime == 0) {
                # $num evenly divided by $prime, exit the for loop
                $num_is_prime = 0;
                last;
            }
        }
        push @primes, $num if $num_is_prime; #  Add $num to the array of primes
    }
    return @primes;
}

my @prime_numbers = find_primes;

sub is_prime {
    my $num = shift;
    my $limit = 1 + int $num ** 0.5;
    for my $p (@prime_numbers) {
        return 1 if $p > $limit;
        return 0 if $num % $p == 0;
    }
    warn "Something got wrong (primes list too small)\n";
    return 0; # If we've reached this point, then our list of
              # primes is too small, we don't know if the argument
              # is prime, issue a warning and return a false
              # value to be on the safe side of things
}

for my $i (0..20) {
    my $euclid_1 = 1;
    $euclid_1 *= $prime_numbers[$_] for 0..$i;
    my $euclid = $euclid_1 + 1;
    say $euclid and last unless is_prime $euclid;
}
