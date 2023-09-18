#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 235 Task 2 Duplicate Zeros 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to duplicate each occurrence of ZERO in the given array
# and shift the remaining to the right but make sure the size of array
# remain the same.
# Example 1 Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
#           Ouput: (1, 0, 0, 2, 3, 0, 0, 4)
# Example 2 Input: @ints = (1, 2, 3)
#           Ouput: (1, 2, 3)
# Example 3 Input: @ints = (0, 3, 0, 4, 5)
#           Ouput: (0, 0, 3, 0, 0)
#=============================================================================

use v5.36;

use FindBin qw($Bin);
use lib "$FindBin::Bin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub duplicateZeros(@ints)
{
    [ (map { $_ || (0,0) } @ints)[0 .. $#ints] ]
}

sub dz_A(@ints)
{
    my $maxLen = @ints;
    my @output;
    while ( @output < $maxLen )
    {
        push @output, shift @ints;
        push @output, 0 if ( $output[-1] == 0 && @output < $maxLen );
    }
    return \@output;
}

sub runTest
{
    use Test2::V0;

    is( duplicateZeros(1,0,2,3,0,4,5,0), [1,0,0,2,3,0,0,4], "Example 1");
    is( duplicateZeros(1,2,3          ), [1,2,3          ], "Example 2");
    is( duplicateZeros(0,3,0,4,5      ), [0,0,3,0,0      ], "Example 3");
    is( duplicateZeros(0), [0], "One Zero");
    is( duplicateZeros(2, 1, 0), [2, 1, 0], "Ends on a zero");

    is( dz_A(1,0,2,3,0,4,5,0), [1,0,0,2,3,0,0,4], "Example 1");
    is( dz_A(1,2,3          ), [1,2,3          ], "Example 2");
    is( dz_A(0,3,0,4,5      ), [0,0,3,0,0      ], "Example 3");
    is( dz_A(0), [0], "One Zero");
    is( dz_A(2, 1, 0), [2, 1, 0], "Ends on a zero");

    done_testing;
}
