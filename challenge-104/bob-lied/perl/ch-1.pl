#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 104, Task #1, FUSC Sequence
# Write a script to generate first 50 members of FUSC Sequence. Please refer
# to OEIS for more information. The sequence defined as below:
# 
# fusc(0) = 0
# fusc(1) = 1
# for n > 1:
# when n is even: fusc(n) = fusc(n / 2),
# when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)
# 
#=============================================================================

use strict;
use warnings;
use v5.32;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use Memoize;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $N = shift // 50;

say "$_: ", fusc($_) for 0 .. $N;

#memoize("fusc");
sub fusc($n)
{
    use integer;
    return 0 if $n == 0;
    return 1 if $n == 1;

    return fusc($n/2) if ($n % 2) == 0;
    return fusc(($n-1)/2) + fusc(($n+1)/2);
}

sub runTest
{
    use Test::More;

    is( fusc( 0),  0, "fusc( 0)");
    is( fusc( 1),  1, "fusc( 1)");
    is( fusc( 2),  1, "fusc( 2)");
    is( fusc( 3),  2, "fusc( 3)");
    is( fusc( 4),  1, "fusc( 4)");
    is( fusc( 5),  3, "fusc( 5)");
    is( fusc( 6),  2, "fusc( 6)");
    is( fusc( 7),  3, "fusc( 7)");
    is( fusc( 8),  1, "fusc( 8)");
    is( fusc( 9),  4, "fusc( 9)");
    is( fusc(10),  3, "fusc(10)");
    is( fusc(11),  5, "fusc(11)");
    is( fusc(12),  2, "fusc(12)");
    is( fusc(13),  5, "fusc(13)");
    is( fusc(14),  3, "fusc(14)");
    is( fusc(15),  4, "fusc(15)");
    is( fusc(16),  1, "fusc(16)");
    is( fusc(20),  3, "fusc(20)");
    is( fusc(30),  4, "fusc(30)");
    is( fusc(40),  3, "fusc(40)");
    is( fusc(50),  7, "fusc(50)");
    is( fusc(60),  4, "fusc(60)");
    is( fusc(70),  9, "fusc(70)");
    is( fusc(80),  3, "fusc(80)");
    is( fusc(90), 12, "fusc(90)");


    done_testing;
}

