#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 72  Task 1 Trailing Zeroes 
#=============================================================================
#
# You are given a positive integer $N (<= 10).
# Write a script to print number of trailing zeroes in $N!.

use strict;
use warnings;
use feature qw(say);

use Getopt::Long;

sub Usage { "Usage: $0 N\n\tN <= 10" }


sub trailingZero
{
    my ($n) = @_;
    return int($n/5);
}

use Memoize;
memoize('_fact');

sub _fact
{
    my ($product, $n) = @_;
    return $product if $n < 2;
    return _fact($n*$product, $n-1);
}

sub factorial
{
    my ($n) = @_;
    return 1 if $n < 2;
    return _fact($n, $n-1);
}

sub runTests
{
    use Test::More;

    is ( factorial( 0),                   1, "f( 0)" );
    is ( factorial( 1),                   1, "f( 1)" );
    is ( factorial( 2),                   2, "f( 2)" );
    is ( factorial( 3),                   6, "f( 3)" );
    is ( factorial( 4),                  24, "f( 4)" );
    is ( factorial( 5),                 120, "f( 5)" );
    is ( factorial( 6),                 720, "f( 6)" );
    is ( factorial( 7),                5040, "f( 7)" );
    is ( factorial( 8),               40320, "f( 8)" );
    is ( factorial( 9),              362880, "f( 9)" );
    is ( factorial(10),             3628800, "f(10)" );
    is ( factorial(15),       1307674368000, "f(15)" );
    is ( factorial(20), 2432902008176640000, "f(20)" );

    is( trailingZero( 0),  0, "for  0");
    is( trailingZero( 1),  0, "for  1");
    is( trailingZero( 2),  0, "for  2");
    is( trailingZero( 3),  0, "for  3");
    is( trailingZero( 4),  0, "for  4");
    is( trailingZero( 5),  1, "for  5");
    is( trailingZero( 6),  1, "for  6");
    is( trailingZero( 7),  1, "for  7");
    is( trailingZero( 8),  1, "for  8");
    is( trailingZero( 9),  1, "for  9");
    is( trailingZero(10),  2, "for 10");
    is( trailingZero(20),  4, "for 20");

    done_testing();

}

########## main

my $doTest;
GetOptions('test!' => \$doTest);

exit(!runTests()) if $doTest;

die Usage unless scalar(@ARGV) == 1;

my $N = shift;
die Usage unless $N > 0 && $N <= 10;

say trailingZero($N);
