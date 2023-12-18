#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 248 Task 2 Submatrix Sum
#=============================================================================
# You are given a NxM matrix A of integers.
# Write a script to construct a (N-1)x(M-1) matrix B having elements that
# are the sum over the 2x2 submatrices of A,
# b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]
# Example 1 Input: $a = [ [1,  2,  3,  4],
#                         [5,  6,  7,  8],
#                         [9, 10, 11, 12] ]
#           Output: $b = [ [14, 18, 22],
#                          [30, 34, 38] ]
# Example 2 Input: $a = [ [1, 0, 0, 0],
#                         [0, 1, 0, 0],
#                         [0, 0, 1, 0],
#                         [0, 0, 0, 1] ]
#           Output: $b = [ [2, 1, 0],
#                          [1, 2, 1],
#                          [0, 1, 2] ]
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub sms($m)
{
    my $height = $m->$#*;
    my $width  = $m->[0]->$#*;

    my @output;
    push @output, [ (0) x $width ] for 0 .. $height -1;

    for my $i (  0 .. $height-1 )
    {
        for my $k ( 0 .. $width-1 )
        {
            $output[$i][$k] = $m->[$i  ][$k] + $m->[$i  ][$k+1]
                            + $m->[$i+1][$k] + $m->[$i+1][$k+1];
        }
    }
    return \@output;
}

sub runTest
{
    use Test2::V0;

    is( sms( [ [1,  2,  3,  4],
               [5,  6,  7,  8],
               [9, 10, 11, 12] ]),
            [ [14, 18, 22], [30, 34, 38] ] , "Example 1");

    is( sms( [ [1, 0, 0, 0],
               [0, 1, 0, 0],
               [0, 0, 1, 0],
               [0, 0, 0, 1] ] ),
            [ [2, 1, 0],
              [1, 2, 1],
              [0, 1, 2] ], "Example 2");

    done_testing;
}
