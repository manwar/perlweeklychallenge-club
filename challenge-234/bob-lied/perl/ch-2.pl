#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Unequal Triplets 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of positive integers.
# Write a script to find the number of triplets (i, j, k) that satisfies
# num[i] != num[j], num[j] != num[k] and num[k] != num[i].
# Example 1 Input: @ints = (4, 4, 2, 4, 3)
#           Output: 3
#   (0, 2, 4) because 4 != 2 != 3
#   (1, 2, 4) because 4 != 2 != 3
#   (2, 3, 4) because 2 != 4 != 3
# Example 2 Input: @ints = (1, 1, 1, 1, 1)
#           Output: 0
# Example 3 Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
#           Output: 28
#   triplets of 1, 4, 7  = 3x2×2 = 12 combinations
#   triplets of 1, 4, 10 = 3×2×1 = 6  combinations
#   triplets of 4, 7, 10 = 2×2×1 = 4  combinations
#   triplets of 1, 7, 10 = 3x2x1 = 6 combinations
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub unequalTriplets(@num)
{
    return 0 if @num < 3;
    # Make a hash that maps each element to the number of times it occurs
    my %freq;
    $freq{$_}++ for @num;

    # The keys of the hash are all different, so all combinations of three
    # elements from the keys will satisfy the inequality condition.
    my @n = keys %freq;

    # As example 3 shows, we don't have to enumerate the possibilities,
    # we just have to calculate the number of combinations.
    my $count = 0;
    for ( my $i = 0; $i <= $#n - 2 ; $i++ )
    {
        for ( my $j = $i+1; $j <= $#n-1; $j++ )
        {
            for ( my $k = $j+1 ; $k <= $#n; $k++ )
            {
                $count += $freq{$n[$i]} * $freq{$n[$j]} * $freq{$n[$k]};
            }
        }
    }
    return $count;
}

sub runTest
{
    use Test2::V0;
    
    is( unequalTriplets(1),     0, "Not enough 1");
    is( unequalTriplets(1,2,3), 1, "Just 3, but different");
    is( unequalTriplets(1,2,2), 0, "Just 3, not different a");
    is( unequalTriplets(1,2,1), 0, "Just 3, not different b");
    is( unequalTriplets(1,1,2), 0, "Just 3, not different c");

    is( unequalTriplets(4,4,2,4,3),         3, "Example 1");
    is( unequalTriplets(1,1,1,1,1),         0, "Example 2");
    is( unequalTriplets(4,7,1,10,7,4,1,1), 28, "Example 3");

    done_testing;
}
