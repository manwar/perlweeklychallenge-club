#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/
#
#              Task 1 - Prime Sum
#
#       AUTHOR: Lubos Kolouch
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util qw/is_prime/;

sub get_nr_primes {
    my $what = shift;

    # if the number is prime, we need just 1 number to represent it

    return 1 if is_prime($what);

    # if the number is even, we need 2 primes thanks to Goldbach's conjecture
    return 2 if $what % 2 == 1;

    # if the number - 2 is prime, return 2
    return 2 if is_prime($what - 2);

    # if the number -3 is prime, return 2 (3 and the prime)
    return 2 if is_prime($what - 3);

    # otherwise return 3 - it is 3 and 2 primes forming $what - 3 thanks to
    # Goldbach's conjecture
    
    return 3
}


use Test::More;

is(get_nr_primes(9), 2, 'test 9');
is(get_nr_primes(10), 2, 'test 10');
is(get_nr_primes(2), 1, 'test 2');

done_testing;
