#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge week 137, Task #2, Lychrel number 
#
# You are given a number, 10 <= $n <= 1000.
# Write a script to find out if the given number is Lychrel number. To keep
# the task simple, we impose the following rules:
#   a. Stop if the number of iterations reached 500.
#   b. Stop if you end up with number >= 10_000_000.
#
# According to wikipedia:
# A Lychrel number is a natural number that cannot form a palindrome through
# the iterative process of repeatedly reversing its digits and adding the
# resulting numbers.
#
# Example 1: Input $n = 56, Output = 0
#   56+65 = 121, found palindrome after 1 iteration
#
# Example 2: Input $n = 57, Output = 0
#   57+75 = 132
#   132+231 = 363, found palindrome after 2 iterations
#=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my $MaxIter = 500;
my $MaxSum  = 10_000_000;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub isPalindrome($n)
{
    return 1 if $n < 10;
    my @dig = split("", $n);
    while ( @dig && $dig[0] == $dig[-1] )
    {
        @dig = @dig[ 1 .. $#dig-1 ];
    }
    return @dig == 0;
}

sub isLychrel($n)
{
    my $iter = 0;
    my $sum  = $n;
    while ( $iter < $MaxIter && $sum < $MaxSum )
    {
        my $revn = join("", reverse split(//, $n));
        $sum = $n + $revn;
        say "$iter: $n + $revn = $sum" if $Verbose;
        return 0 if isPalindrome($sum);
        $n = $sum;
    }
    return 1;
}

sub runTest
{
    use Test::More;

    is( isPalindrome(   1),  1, "P=1");
    is( isPalindrome(  22),  1, "P=22");
    is( isPalindrome(  27), '', "P=27");
    is( isPalindrome( 343),  1, "P=343");
    is( isPalindrome( 346), '', "P=346");

    is( isLychrel( 56), 0, "N=56");
    is( isLychrel( 57), 0, "N=57");
    is( isLychrel( 59), 0, "N=59");
    is( isLychrel(196), 1, "N=196");

    done_testing;
}

