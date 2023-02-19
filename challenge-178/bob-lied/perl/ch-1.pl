#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 178 Task 1 Quater-Imaginary Base
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to convert a given number (base 10) to quater-imaginary base
# number and vice-versa. For more informations, please checkout wiki page.
# https://en.wikipedia.org/wiki/Quater-imaginary_base
# For example,
# $number_base_10 = 4
# $number_quater_imaginary_base = 10300
#
# The quater-imaginary base is a represention of numbers using the imaginary
# number 2i as the base.  Complex numbers are represented with even powers
# as the real part, and odd powers as the imaginary part.
# k   (2i)^k
# --  ------
#  0       1
#  1       2i
#  2      -4
#  3      -8i
#  4      16
#  5      32i
#  6     -64
#  7    -128i
#  8     256
#  9     512i
# 10   -1024
# 11   -2048i
#
# The base 2i is related to the base -4.  Every even power of 2i is a
# power of -4.  For real numbers, using -4 as a base gives a representation
# where every other digit is 0.
#==============================================================================

use v5.36;

use List::MoreUtils qw/part/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub q2d($n)
{
    # Reverse the digits so the indices match the exponents
    my @digit = split '', reverse scalar "$n";

    # Divide into even and odd exponents.  The even exponents
    # will be the real part; the odd will be imaginary.
    my @exponent = part { ($_ % 2) } 0 .. $#digit;

    my @evenPower = @digit[ $exponent[0]->@* ];
    my @oddPower  = defined $exponent[1] ? @digit[ $exponent[1]->@* ] : ();

    my ($re, $im) = (0, 0);
    for ( my $k = 0; $k <= $#evenPower ; $k++ )
    {
        my $sign = ( ($k % 2) ? -1 : 1 );
        my $val = $sign * $evenPower[$k] * (2 ** (2*$k));
        $re += $val;
    }

    for ( my $k = 0; $k <= $#oddPower ; $k++ )
    {
        my $sign = (($k+1) %2 ? -1 : 1 );
        my $val = $sign * $oddPower[$k] * (2 ** (2*($k+1)));
        $im += $val;
    }

    return ($im == 0 ) ? "$re" : "$re +${im}i";
}

# Only handles real integers
sub d2q($n)
{
    my @digit;

    return 0 if $n == 0;

    # Using base -4 for conversion
    while ( $n != 0 )
    {
        my $q = int($n / -4);
        my $rem = $n - ($q * -4);
        $n = $q;

        if ( $rem < 0 )
        {
            # Convert negative remainders to positive with
            # clock arithmetic, effectively subtract and carry
            ($n, $rem) = ($n + 1, $rem + 4)
        }
        unshift @digit, $rem;
    }
    # To convert to base 2i, put a zero between each digit
    return join("0", @digit);
}

sub runTest
{
    use Test2::V0;

    is( q2d("1"),      1,  "quat to dec 1");
    is( q2d("2"),      2,  "quat to dec 2");
    is( q2d("3"),      3,  "quat to dec 3");
    is( q2d("10300"),  4,  "quat to dec 4");
    is( q2d("10301"),  5,  "quat to dec 5");
    is( q2d("10302"),  6,  "quat to dec 6");
    is( q2d("10303"),  7,  "quat to dec 7");
    is( q2d("10200"),  8,  "quat to dec 8");
    is( q2d("10201"),  9,  "quat to dec 9");
    is( q2d("10202"), 10,  "quat to dec 10");
    is( q2d("10203"), 11,  "quat to dec 11");
    is( q2d("10100"), 12,  "quat to dec 12");
    is( q2d("10101"), 13,  "quat to dec 13");
    is( q2d("10102"), 14,  "quat to dec 14");
    is( q2d("10103"), 15,  "quat to dec 15");
    is( q2d("10000"), 16,  "quat to dec 16");

    is( d2q(-4),   "100", "dec to quat -4");
    is( d2q(-3),   "101", "dec to quat -3");
    is( d2q(-2),   "102", "dec to quat -2");
    is( d2q(-1),   "103", "dec to quat -1");
    is( d2q( 0),     "0", "dec to quat 0");
    is( d2q( 1),     "1", "dec to quat 1");
    is( d2q( 2),     "2", "dec to quat 2");
    is( d2q( 3),     "3", "dec to quat 3");
    is( d2q( 4), "10300", "dec to quat 4");
    is( d2q( 5), "10301", "dec to quat 5");
    is( d2q( 6), "10302", "dec to quat 6");
    is( d2q( 7), "10303", "dec to quat 7");
    is( d2q( 8), "10200", "dec to quat 8");
    is( d2q( 9), "10201", "dec to quat 9");
    is( d2q(10), "10202", "dec to quat 10");
    is( d2q(11), "10203", "dec to quat 11");
    is( d2q(12), "10100", "dec to quat 12");
    is( d2q(13), "10101", "dec to quat 13");
    is( d2q(14), "10102", "dec to quat 14");
    is( d2q(15), "10103", "dec to quat 15");
    is( d2q(16), "10000", "dec to quat 16");

    done_testing;
}

