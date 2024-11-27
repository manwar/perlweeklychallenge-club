#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 290 Task 2 Luhn's Algorithm
#=============================================================================
# You are given a string $str containing digits (and possibly other
# characters which can be ignored). The last digit is the payload; consider
# it separately. Counting from the right, double the value of the first,
# third, etc. of the remaining digits.
# 
# For each value now greater than 9, sum its digits.
# 
# The correct check digit is that which, added to the sum of all values,
# would bring the total mod 10 to zero.
# Return true if and only if the payload is equal to the correct check digit.
# Example 1 Input: "17893729974"
#           Output: true
#   Payload is 4.   1 >7 8 >9 3 >7 2 >9 9 >7
# Digits from the right:
#    1) 7 * 2 = 14, sum =  5
#    2) 9               =  9
#    3) 9 * 2 = 18, sum =  9
#    4) 2               =  2
#    5) 7 * 2 = 14, sum =  5
#    6) 3               =  3
#    7) 9 * 2 = 18, sum =  9
#    8) 8               =  8
#    9) 7 * 2 = 14, sum =  5
#   10) 1               =  1
#   Sum of all values   = 56,
#   so 4 must be added to bring the total mod 10 to zero.
#   The payload is indeed 4.
#
# Example 2 Input: "4137 8947 1175 5904"
#           Output: true
# Example 3 Input: "4137 8974 1175 5904"
#           Output: false
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say (luhnCheck($_) ? "true" : "false") for @ARGV;


sub luhnPayload($str)
{
    use integer;
    my @digit = reverse split('', ($str =~ s/\D//gr));

    my $isOdd = true;
    my $sum = 0;
    for ( @digit )
    {
        if ( $isOdd ) { $sum += ( $_ < 5 ? 2*$_ : (1 + (2*$_-10)) ) }
        else          { $sum += $_ }
        $isOdd = ! $isOdd;
    }
    my $p = $sum % 10;
    return ( $p ? (10-$p) : 0 );
}

sub luhnCheck($str)
{
    my $payload = substr($str, -1);
    return $payload == luhnPayload( substr($str, 0, length($str)-1) );
}

sub runTest
{
    use Test2::V0;

    is( luhnPayload("1"),                  8, "Payload 1");
    is( luhnPayload("1789372997"),         4, "Payload Example 1");
    is( luhnPayload("4137 8947 1175 590"), 4, "Payload Example 2");
    is( luhnPayload("4137 8974 1175 590"), 0, "Payload Example 3");

    is( luhnCheck("17893729974"        ),  true, "Example 1");
    is( luhnCheck("4137 8947 1175 5904"),  true, "Example 2");
    is( luhnCheck("4137 8974 1175 5904"), false, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
