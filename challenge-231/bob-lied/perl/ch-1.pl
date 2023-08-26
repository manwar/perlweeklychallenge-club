#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 231 Task 1 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of distinct integers.
# Write a script to find all elements that is neither minimum nor maximum.
# Return -1 if you can’t.
# Example 1 Input: @ints = (3, 2, 1, 4)
#           Output: (3, 2)
#   The minimum is 1 and maximum is 4 in the given array.
#   So (3, 2) is neither min nor max.
# Example 2 Input: @ints = (3, 1)
#           Output: -1
# Example 3 Input: @ints = (2, 1, 3)
#           Output: (2)
#   The minimum is 1 and maximum is 3 in the given array.
#   So 2 is neither min nor max.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $inMinMax = minMax(@ARGV);
if ( @$inMinMax == 0 )
{
    say "-1";
}
else
{
    say "(", join(", ", $inMinMax->@*), ")";
}

sub minMax(@list)
{
    my ($min, $max) = ($list[0], $list[0]);

    # One pass to find the minimum and the maximum.
    # Could also use List::MoreUtils::minmax
    for my $elem ( @list )
    {
        $min = $elem if $elem < $min;
        $max = $elem if $elem > $max;
    }

    return [ grep { $_ > $min && $_ < $max } @list ];
}

# Does not preserve order of elements
sub minMax_sort(@list)
{
    my @sorted = sort { $a <=> $b } @list;
    return [ grep { $_ > $sorted[0] && $_ < $sorted[-1] } @sorted ];
}

sub runTest
{
    use Test2::V0;

    is( minMax(3,2,1,4), [3,2], "Example 1");
    is( minMax(3,1),     [],    "Example 2");
    is( minMax(2,1,3  ), [2],   "Example 3");

    is( minMax_sort(3,2,1,4), [2,3], "Example 1");
    is( minMax_sort(3,1),     [],    "Example 2");
    is( minMax_sort(2,1,3  ), [2],   "Example 3");

    done_testing;
}
