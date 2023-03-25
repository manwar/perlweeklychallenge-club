#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 175 Task 2 Totient
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to generate first 20 Perfect Totient Numbers.
# Please checkout wikipedia page for more informations.
#  https://en.wikipedia.org/wiki/Perfect_totient_number
# Output
# 3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
# 2187, 2199, 3063, 4359, 4375, 5571
####
# In number theory, a perfect totient number is an integer that is equal to
# the sum of its iterated totients. That is, we apply the totient function to
# a number n, apply it again to the resulting totient, and so on, until the
# number 1 is reached, and add together the resulting sequence of numbers; if
# the sum equals n, then n is a perfect totient number.
#
# For example, there are six positive integers less than 9 and relatively
# prime to it, so the totient of 9 is 6; there are two numbers less than 6 and
# relatively prime to it, so the totient of 6 is 2; and there is one number
# less than 2 and relatively prime to it, so the totient of 2 is 1; and 9 = 6
# + 2 + 1, so 9 is a perfect totient number.
###

# In number theory, Euler's totient function counts the positive integers up
# to a given integer n that are relatively prime to n. In other words, it is
# the number of integers k in the range 1 ≤ k ≤ n for which the greatest
# common divisor gcd(n, k) is equal to 1. The integers k of this form
# are sometimes referred to as totatives of n.

# For example, the totatives of n = 9 are the six numbers 1, 2, 4, 5, 7 and 8.
# They are all relatively prime to 9, but the other three numbers in this
# range, 3, 6, and 9 are not, since gcd(9, 3) = gcd(9, 6) = 3 and gcd(9, 9) =
# 9. Therefore, φ(9) = 6. As another example, φ(1) = 1 since for n = 1 the
# only integer in the range from 1 to n is 1 itself, and gcd(1, 1) = 1. 

#=============================================================================

use v5.36;


# The totient function is also known as Euler's phi function, and there is an
# implementation of it in the ntheory (Math::Prime::Util) module.
use Math::Prime::Util qw/euler_phi/;

use builtin qw/true false/;
no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $count = 0;
my $n = 2;
while ( $count < 20 && $n++ < 10_000 )
{
    do { $count++, say $n } if isPerfectTotient($n);
}

sub isPerfectTotient($n)
{
    my $sum = my $totient = euler_phi($n);
    until ( $totient == 1 )
    {
        $totient = euler_phi($totient);
        $sum += $totient;
    }
    return $sum == $n;
}

sub runTest
{
    use Test2::V0;
    no warnings "experimental::builtin";

    is( isPerfectTotient(   3),  true, "is   3");
    is( isPerfectTotient(   4), false, "is   4");
    is( isPerfectTotient(   9),  true, "is   9");
    is( isPerfectTotient(  15),  true, "is  15");
    is( isPerfectTotient(  27),  true, "is  27");
    is( isPerfectTotient(  39),  true, "is  39");
    is( isPerfectTotient(  81),  true, "is  81");
    is( isPerfectTotient( 111),  true, "is 111");
    is( isPerfectTotient( 183),  true, "is 183");
    is( isPerfectTotient( 243),  true, "is 243");
    is( isPerfectTotient( 255),  true, "is 255");
    is( isPerfectTotient( 327),  true, "is 327");
    is( isPerfectTotient( 363),  true, "is 363");
    is( isPerfectTotient( 471),  true, "is 471");
    is( isPerfectTotient( 729),  true, "is 729");
    is( isPerfectTotient(2187),  true, "is 2187");
    is( isPerfectTotient(2199),  true, "is 2199");
    is( isPerfectTotient(3063),  true, "is 3063");
    is( isPerfectTotient(4359),  true, "is 4359");
    is( isPerfectTotient(4375),  true, "is 4375");
    is( isPerfectTotient(5571),  true, "is 5571");
    is( isPerfectTotient(5572), false, "is 5572");

    done_testing;
}

