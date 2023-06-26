#!/usr/bin/env perl

# You are given a positive integer, $n.
# 
# Write a script to find the total count of primes less than or equal to the given integer.
# 
# Example 1
# 
# Input: $n = 10
# Output: 4
# 
# Since there are 4 primes (2,3,5,7) less than or equal to 10.
# 
# Example 2
# 
# Input: $n = 1
# Output: 0
# 
# Example 3
# 
# Input: $n = 20
# Output: 8
# 
# Since there are 4 primes (2,3,5,7,11,13,17,19) less than or equal to 20.


use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    10,
    1,
    20,
    7920,
];

sub is_prime
{
    my $n = shift;

    return 0 if $n <= 1;
  
    for my $i (2 .. $n-1) {
        return 0 if ($n % $i) == 0;
    }
  
    return 1;
}
  
sub count_primes
{
    my $n = shift;
    my $c = 0;
    for my $i (2 .. $n) {
        ++$c if is_prime($i);
    }
    return $c;
}

is(count_primes($cases->[0]),    4, 'n = 10');
is(count_primes($cases->[1]),    0, 'n = 1');
is(count_primes($cases->[2]),    8, 'n = 20');
is(count_primes($cases->[3]), 1000, 'n = 7920');
done_testing();

exit 0;
