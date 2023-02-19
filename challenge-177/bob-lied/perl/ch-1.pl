#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 177 Task 1 Damm Algorithm
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a positive number, $n.
# Write a script to validate the given number against the included check digit.
# Please checkout the wikipedia page for information.
# https://en.wikipedia.org/wiki/Damm_algorithm
# Example 1 Input: $n = 5724 Output: 1 as it is valid number
# Example 2 Input: $n = 5727 Output: 0 as it is invalid number
# 
# From Wikipedia:
# The validity of a digit sequence containing a check digit is defined over a
# quasigroup. A quasigroup table ready for use can be taken from Damm's
# dissertation. It is useful if each main diagonal entry is 0 because it
# simplifies the check digit calculation.
#
# Validating a number against the included check digit
#
#   Set up an interim digit and initialize it to 0.  Process the number digit
#   by digit: Use the number's digit as column index and the interim digit as
#   row index, take the table entry and replace the interim digit with it.
#   The number is valid if and only if the resulting interim digit has the
#   value of 0.
#
# Calculating the check digit
# Prerequisite: The main diagonal entries of the table are 0.
#
#   Set up an interim digit and initialize it to 0.  Process the number digit
#   by digit: Use the number's digit as column index and the interim digit as
#   row index, take the table entry and replace the interim digit with it.
#   The resulting interim digit gives the check digit and will be appended as
#   trailing digit to the number.
#
# A full example follows in the article.
#=============================================================================

use v5.36;

# Magic.  Taken from Wikipedia article.
my @Table = (
    # 0   1   2   3   4   5   6   7   8   9
    [ 0 , 3 , 1 , 7 , 5 , 9 , 8 , 6 , 4 , 2 ], # 0
    [ 7 , 0 , 9 , 2 , 1 , 5 , 4 , 8 , 6 , 3 ], # 1
    [ 4 , 2 , 0 , 6 , 8 , 7 , 1 , 3 , 5 , 9 ], # 2
    [ 1 , 7 , 5 , 0 , 9 , 8 , 3 , 4 , 2 , 6 ], # 3
    [ 6 , 1 , 2 , 3 , 0 , 4 , 5 , 9 , 7 , 8 ], # 4
    [ 3 , 6 , 7 , 4 , 2 , 0 , 9 , 5 , 8 , 1 ], # 5
    [ 5 , 8 , 6 , 9 , 7 , 2 , 0 , 1 , 3 , 4 ], # 6
    [ 8 , 9 , 4 , 5 , 3 , 6 , 2 , 0 , 1 , 7 ], # 7
    [ 9 , 4 , 3 , 8 , 6 , 1 , 7 , 2 , 0 , 5 ], # 8
    [ 2 , 5 , 8 , 1 , 4 , 3 , 6 , 7 , 9 , 0 ], # 9
);
use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub checkDamm($n)
{
    my $interim = 0;
    for my $digit ( split '', "$n" )
    {
        say "digit=$digit interim=$interim next=$Table[$interim][$digit]" if $Verbose;
        $interim = $Table[$interim][$digit];
    }
    return $interim == 0 ? 1 : 0;
}

sub runTest
{
    use Test2::V0;

    is( checkDamm(5724), 1, "Example 1");
    is( checkDamm(5727), 0, "Example 2");

    done_testing;
}

