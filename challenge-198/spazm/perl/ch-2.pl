#!/usr/bin/env perl
use v5.34;

use experimental qw(signatures);
use Math::Prime::Util qw(primes);

=pod
Task 2: Prime Count
Submitted by: Mohammad S Anwar

You are given an integer $n > 0.

Write a script to print the count of primes less than $n.
=cut

sub count_of_primes ($n)
{
    return scalar @{ primes($n) };
}

sub main
{
    for my $n ( 0, 1, 10, 15, 25 )
    {
        printf( "there are %d primes less than %i\n",
            count_of_primes($n), $n );
    }
}

main();
