#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 223 Task1 Count Primes
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a positive integer, $n.
# Write a script to find the total count of primes less than or equal to the
# given integer.
# Example 1 Input: $n = 10 Output: 4
#   Since there are 4 primes (2,3,5,7) less than or equal to 10.
# Example 2 Input: $n = 1 Output: 0
# Example 3 Input: $n = 20 Output: 8
#   Since there are 4 primes (2,3,5,7,11,13,17,19) less than or equal to 20.
#=============================================================================

use v5.36;

use builtin qw(true false); no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub sieve($n)
{
    my @prime = (false, false, true, (true,false) x (($n-1)/2) );

    for (my $p = 3; $p*$p <= $n; $p++ )
    {
        if ( $prime[$p] )
        {
            for (my $i = $p*$p ; $i <= $n ; $i += $p )
            {
                $prime[$i] = false;
            }
        }
    }
    my $count = grep { $prime[$_] } 2 .. $n+1;
}

sub countPrimes($n)
{
    return ( $n < 2 ? 0 : sieve($n) );
}

sub runTest
{
    use Test2::V0;

    is( countPrimes(  10),   4, "Example 1");
    is( countPrimes(   1),   0, "Example 2");
    is( countPrimes(  20),   8, "Example 3");
    is( countPrimes(   2),   1, "p 2");
    is( countPrimes(   3),   2, "p 3");
    is( countPrimes(  11),   5, "p 11");
    is( countPrimes( 100),  25, "p 100");
    is( countPrimes(1000), 168, "p 1000");

    done_testing;
}
