#!/usr/bin/env perl

# Challenge 041
#
# TASK #1
# Write a script to display attractive number between 1 and 50.
# A number is an attractive number if the number of its prime factors is also
# prime number.
#
# The number 20 is an attractive number, whose prime factors are 2, 2 and 5.
# The total prime factors is 3 which is also a prime number.

use Modern::Perl;
use ntheory qw( is_prime factor );

my @attractive = grep {is_attractive($_)} 1..50;
say join(", ", @attractive);

sub is_attractive {
    my($n) = @_;
    my @factors = factor($n);
    return is_prime(scalar(@factors));
}
