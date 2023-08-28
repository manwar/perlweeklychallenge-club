#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 229 Task 2 Two Out of Three
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given three array of integers.
# Write a script to return all the elements that are present in at least
# 2 out of 3 given arrays.
# Example 1 Input: @array1 = (1, 1, 2, 4)
#                  @array2 = (2, 4)
#                  @array3 = (4)
#       Ouput: (2, 4)
#
# Example 2 Input: @array1 = (4, 1)
#                  @array2 = (2, 4)
#                  @array3 = (1, 2)
#       Ouput: (1, 2, 4)
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub twoOutOfThree($arrayOfarray)
{
    my %appearsIn;
    # Count number of arrays, should be 0,1,2
    for my $v ( 0 .. $arrayOfarray->$#* )
    {
        # Set a bit corresponding to the vector we're looking at.
        my $bit = 1 << $v;

        # Loop over elements in one of the arrays.
        for my $elem ( $arrayOfarray->[$v]->@* )
        {
            $appearsIn{$elem} |= $bit;
        }
    }

    # Possible bit combinations where at least two of three bits are set
    # 0 -- 0 0 0 -- no
    # 1 -- 0 0 1 -- no
    # 2 -- 0 1 0 -- no
    # 3 -- 0 1 1 -- YES
    # 4 -- 1 0 0 -- no
    # 5 -- 1 0 1 -- YES
    # 6 -- 1 1 0 -- YES
    # 7 -- 1 1 1 -- YES
    
    return [ grep { my $n = $appearsIn{$_}; $n == 0x3 || $n > 0x4 }
             sort keys %appearsIn
           ];
}

sub runTest
{
    use Test2::V0;

    is( twoOutOfThree( [ [1,1,2,4], [2,4], [4] ] ), [2, 4],     "Example 1");
    is( twoOutOfThree( [ [4,1], [2,4], [1,2] ] ),   [1,2,4], "Example 2");

    is( twoOutOfThree( [ [1,2,2], [1,3,4], [1,5,6] ] ), [1],   "Twice in one");
    is( twoOutOfThree( [ [1,2,2], [1,2,4], [1,5,6] ] ), [1,2], "Thrice in two");

    done_testing;
}
