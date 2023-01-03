#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Perl Weekly Challenge Week 198, Task 2 Prime Count
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an integer $n > 0.
# Write a script to print the count of primes less than $n.
# Example 1 Input: $n = 10 Output: 4, as primes less than 10 are 2, 3, 5 ,7.
# Example 2 Input: $n = 15 Output: 6
# Example 3 Input: $n = 1 Output: 0
# Example 4 Input: $n = 25 Output: 9
#=============================================================================

use v5.36;

use Math::Prime::Util qw/prime_count/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

for ( @ARGV )
{
    next unless /[0-9]+/;
    say primeCount($_);
}

sub primeCount($n)
{
    # Spec says < n, prime_count would include n
    return Math::Prime::Util::prime_count($n - 1)
}

sub runTest
{
    use Test::More;

    is( primeCount(10), 4, "Example 1");
    is( primeCount(15), 6, "Example 2");
    is( primeCount( 1), 0, "Example 3");
    is( primeCount(25), 9, "Example 4");

    done_testing;
}
