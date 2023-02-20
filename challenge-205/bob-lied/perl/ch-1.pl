#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 205 Task 1 Third Highest
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to find out the Third Highest if found otherwise return
# the maximum.
# Example 1 Input: @array = (5,3,4) Output: 3
#   First highest is 5. Second highest is 4. Third highest is 3.
# Example 2 Input: @array = (5,6) Output: 6
#   First highest is 6. Second highest is 5. Third highest is missing,
#   so maximum is returned.
# Example 2 Input: @array = (5,4,4,3) Output: 3
#   First highest is 5. Second highest is 4. Third highest is 3.
#=============================================================================

use v5.36;

use List::Util qw/max/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say thirdHighest(@ARGV);

sub thirdHighest(@array)
{
    return 0 if !@array;

    my @top3 = ( shift @array ); # In descending order

    for my $elem ( @array )
    {
        # Add the element to the front of the list of possibiliities
        unshift @top3, $elem;

        # Bubble the element down to its sorted position
        # but we only care about the top 3 positions
        ELEM: for ( my $i = 0 ; $i < $#top3 && $i < 3 ; $i++ )
        {
            for ( my $j = $i + 1 ; $j < 3 ; $j++ )
            {
                if ( $top3[$i] == $top3[$j] )
                {
                    # Duplicate value, discard
                    splice(@top3, $i, 1);
                    next ELEM;
                }
                elsif ( $top3[$i] < $top3[$j] )
                {
                    # Swap
                    @top3[$i, $j] = @top3[$j, $i];
                }
            }
        }
    }

    return max(@array) if ( scalar(@top3) < 3 );
    return $top3[2];
}

sub runTest
{
    use Test2::V0;

    is( thirdHighest(5,3,4),     3, "Example 1");
    is( thirdHighest(5,6  ),     6, "Example 2");
    is( thirdHighest(5,4,4,3),   3, "Example 3");
    is( thirdHighest(5,5,5,5),   5, "Only one");
    is( thirdHighest(5,5,5,9),   9, "Only two");
    is( thirdHighest(       ),   0, "Test 0");
    is( thirdHighest(5,5,6,7),   5, "Test 1");
    is( thirdHighest(5,6,7,7),   5, "Test 2");
    is( thirdHighest(5,6,6,7,8), 6, "Test 3");
    is( thirdHighest(5,5,6,6,7,7,8,8), 6, "Duplicates");
    is( thirdHighest(2,4,6,8,3,4,6,8), 4, "Duplicates v2");
    is( thirdHighest( 10..99 ),       97, "Longer list");

    done_testing;
}
