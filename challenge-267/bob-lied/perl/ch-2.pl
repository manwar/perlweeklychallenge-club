#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 267 Task 2 Line Counts
#=============================================================================
# You are given a string, $str, and a 26-items array @widths containing
# the width of each character from a to z.
#
# Write a script to find out the number of lines and the width of the
# last line needed to display the given string, assuming you can only
# fit 100 width units on a line.
# Example 1 Input: $str = "abcdefghijklmnopqrstuvwxyz"
#                  @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,
#                             10,10,10,10,10,10,10,10,10,10,10,10,10)
#           Output: (3, 60)
#   Line 1: abcdefghij (100 pixels)
#   Line 2: klmnopqrst (100 pixels)
#   Line 3: uvwxyz (60 pixels)
#
# Example 2 Input: $str = "bbbcccdddaaa"
#                  @widths = ( 4,10,10,10,10,10,10,10,10,10,10,10,10,
#                             10,10,10,10,10,10,10,10,10,10,10,10,10)
#           Output: (2, 4)
#   Line 1: bbbcccdddaa (98 pixels)
#   Line 2: a (4 pixels)
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

use constant { MAXLINE => 100,
               ORD_A   =>  ord('a')
           };

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $str = shift;
my @widths = (10) x 26;
$widths[$_] = $ARGV[$_] for 0 .. $#ARGV;

say '(', join(", ", lineCount($str, @widths)->@* ), ')';

sub lineCount($str, @widths)
{
    # Normalize to lower-case a-z only
    $str = lc $str;
    $str =~ s/[^a-z]//g;

    my $lineCount = 1;
    my $width = 0;

    # Work with character widths, actual characters don't matter
    my @cw = map { $widths[ ord($_) - ORD_A ] } split(//, $str);
    while ( defined(my $w = shift @cw) )
    {
        if ( $width + $w <= MAXLINE )
        {
            $width += $w;
        }
        else
        {
            $width = $w;
            $lineCount++;
        }
    }
    return [ $lineCount, $width ];
}

sub runTest
{
    use Test2::V0;

    my $str;
    my @widths;
    my $lines;
    my $last;

    $str = "abcdefghijklmnopqrstuvwxyz";
    @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,
               10,10,10,10,10,10,10,10,10,10,10,10,10);
    is( lineCount($str, @widths), [ 3, 60 ], "Example 1");

    $str = "bbbcccdddaaa";
    @widths = ( 4,10,10,10,10,10,10,10,10,10,10,10,10,
               10,10,10,10,10,10,10,10,10,10,10,10,10);
    is( lineCount($str, @widths), [ 2, 4 ], "Example 2");

    done_testing;
}
