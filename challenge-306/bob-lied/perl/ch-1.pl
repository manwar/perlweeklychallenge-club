#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 306 Task 1 Odd Sum
#=============================================================================
# You are given an array of positive integers, @ints.
# Write a script to return the sum of all possible odd-length subarrays of
# the given array. A subarray is a contiguous subsequence of the array.
# Example 1 Input: @ints = (2, 5, 3, 6, 4)
#           Output: 77
#   Odd length sub-arrays:
#   (2) => 2 (5) => 5 (3) => 3 (6) => 6 (4) => 4
#   (2, 5, 3) => 10 (5, 3, 6) => 14 (3, 6, 4) => 13
#   (2, 5, 3, 6, 4) => 20
#   Sum => (2 + 5 + 3 + 6 + 4) + (10 + 14 + 13) + 20 => 77
#
# Example 2 Input: @ints = (1, 3)
#           Output: 4
#=============================================================================

use v5.40;

use List::Util qw/sum0/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say oddSum(@ARGV);

#=============================================================================
# This implements the operations literally, but loops repeatedly over
# sub-arrays. It is possible to figure out how many times each element
# appears in the sum as a function of its position and the length of the
# array, which will be much more efficient.
sub oddSum(@ints)
{
    my $sum = sum0 @ints;
    for my $group ( map { 1 + 2*$_ } 1 .. int((@ints-1)/2) )
    {
        $logger->debug("group=$group");
        for (my $i = 0; $i <= @ints-$group; $i++ )
        {
            $sum += $ints[$_] for ( $i .. ($i + $group - 1) );
        }
    }
    return $sum;
}

# The number of times each element appears forms a pattern similar to
# Pascal's triangle:

# array  #  Position under sliding window X times
# length #
#  2     #  1  1
#  3     #  2  2  2
#  4     #  2  3  3  2
#  5     #  3  4  5  4  3
#  6     #  3  5  6  6  5  3
#  7     #  4  6  8  8  8  7  4
#  8     #  4  7  9 10 10  9  7  4
#  9     #  5  8 11 12 13 12 11  8  5
# 10     #  5  9 12 14 15 15 14 12  9  5

sub runTest
{
    use Test2::V0;

    is( oddSum(2,5,3,6,4), 77, "Example 1");
    is( oddSum(1,3      ),  4, "Example 2");

    done_testing;
}
