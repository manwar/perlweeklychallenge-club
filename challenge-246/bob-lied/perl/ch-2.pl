#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 246 Task 2 Linear Recurrence of Second Order 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array @a of five integers.
# Write a script to decide whether the given integers form a linear
# recurrence of second order with integer factors.
# A linear recurrence of second order has the form
# a[n] = p * a[n-2] + q * a[n-1] with n > 1 where p and q must be integers.
# Example 1 Input: @a = (1, 1, 2, 3, 5)
#           Output: true
#   @a is the initial part of the Fibonacci sequence
#   a[n] = a[n-2] + a[n-1] with a[0] = 1 and a[1] = 1.
# Example 2 Input: @a = (4, 2, 4, 5, 7)
#           Output: false
#   a[1] and a[2] are even. Any linear combination of two even numbers
#   with integer factors is even, too.  Because a[3] is odd, the given
#   numbers cannot form a linear recurrence of second order with integer
#   factors.
# Example 3 Input: @a = (4, 1, 2, -3, 8)
#           Output: true
#   a[n] = a[n-2] - 2 * a[n-1]
#-----
# A little algebra.  There are two equations that must hold:
#   a0*p + a1*q = a2  (1)
#   a1*p + a2*q = a3  (2)
# From (1), p = (a2 - a1*q) / a0
# Substiting that into (2), we will get
#   q = (a1*a2 - a0*a3) / ( a1*a1 - a0*a2)
# Using the first four numbers from the sequence we can test if p and q
# are integers. If they are, then we can also test whether a4 and higher
# can be obtained from the same values of p and q.
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say ( isl2(@ARGV) ? "true" : "false" );

sub fq($a0, $a1, $a2, $a3)
{
    my $denom = $a1*$a1 - $a0*$a2;
    say "fq: denom=$denom" if $Verbose;
    return undef if $denom == 0;
    my $q = ($a1*$a2 - $a0*$a3)/$denom;
    say "fq: q=$q" if $Verbose;
    return $q;
}

sub fp($q, $a0, $a1, $a2)
{
    return undef if $a0 == 0;
    my $p = ($a2 - $a1 * $q) / $a0;
    say "fp: p=$p" if $Verbose;
    return $p;
}

sub isl2(@a)
{
    my $q = fq( @a[0..3] );
    return false unless defined $q && int($q) == $q;

    my $p = fp($q, @a[0..2]);
    return false unless defined $p && int($p) == $p;

    # Must also be true for remaing values of @a
    for my $i ( 4 .. $#a )
    {
        my $nexta = $p * $a[$i-2] + $q * $a[$i-1];
        if ( $a[$i] != $nexta )
        {
            say "fails for i=$i, expect $a[$i], got $nexta" if $Verbose;
            return false;
        }
    }
    return true;
}

sub runTest
{
    use Test2::V0;
    no warnings "experimental::builtin";

    is( isl2(1, 1, 2,  3, 5), true,  "Example 1");
    is( isl2(4, 2, 4,  5, 7), false, "Example 2");
    is( isl2(4, 1, 2, -3, 8), true,  "Example 3");

    done_testing;
}
