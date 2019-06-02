#!/usr/bin/perl
use strict;
use warnings;
use feature "say";
use constant largest_num => 100000;

sub find_primes {
    my $num = 5;
    my @primes = (2, 3, 5);
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
        push @primes, $num if $num_is_prime; #  Found a new prime, add it to the array of primes
    }
    return @primes;
}

my @prime_numbers = find_primes;
# print "@prime_numbers \n";

sub is_prime {
    my $num = shift;
    my $limit = 1 + int $num ** 0.5;
    for my $p (@prime_numbers) {
        return 1 if $p > $limit;
        return 0 if $num % $p == 0;
    }
    warn "Something got wrong (primes list too small)\n";
    return 0; # If we've reach this point, then our list of primes is
              # too small, we don't now if the argument is prime, return
              # a false value to be on the safe side of things
}

my @perfect_nums;
for my $prime (@prime_numbers) {
    my $mersenne = 2 ** $prime - 1;
    if (is_prime $mersenne) {
        say "$prime $mersenne ", $mersenne * (2 ** ($prime - 1) );
        push @perfect_nums, $mersenne * (2 ** ($prime - 1) );
        last if scalar @perfect_nums >= 8;
    }
}

say "Perfect numbers: @perfect_nums";
