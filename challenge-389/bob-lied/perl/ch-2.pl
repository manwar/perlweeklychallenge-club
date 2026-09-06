#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 389 Task 2  ZigZag Subarray
#=============================================================================
# You are given an array of integers.  Write a script to find the length of
# the longest contiguous subarray where the numbers alternate between strictly
# increasing and strictly decreasing (a ZigZag pattern).  A sequence of
# numbers $A = [a0, a1, …, ak]$ with length $k >= 1 is considered a ZigZag
# sequence if every adjacent pair alternates direction:
#   a_0 < a_1 > a_2 < a_3 > ...  OR a_0 > a_1 < a_2 > a_3 < ...
# NOTE: A single element (length 1) or any two distinct elements (length 2)
# are automatically valid ZigZag sequences. Equal adjacent numbers (e.g.,
# 5,5) break the pattern.
# Example 1 Input: @nums = (9, 4, 2, 10, 7, 8, 8, 1, 9)
#           Output: 5 ZigZag subarray: (4, 2, 10, 7, 8)
# Example 2 Input: @nums = (1, 7, 4, 9, 2, 5)
#           Output: 6 ZigZag subarray: (1, 7, 4, 9, 2, 5)
# Example 3 Input: @nums = (1, 2, 3, 4, 5)
#           Output: 2 ZigZag subarray: (1, 2)
# Example 4 Input: @nums = (4, 4, 4)
#           Output: 1
# Example 5 Input: @nums = (10, 20, 15, 12, 18)
#           Output: 3 ZigZag subarray: (10, 20, 15)
#=============================================================================

use v5.42;

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

say task(@ARGV);

#=============================================================================
sub task(@nums)
{
    use List::MoreUtils qw/slide/; use List::AllUtils qw/max/;

    return 0 if @nums == 0;
    return 1 if @nums == 1;

    # Convert each change of direction into A (ascending), V (descend), or =
    my $slope = join("", slide { $b > $a ? 'A' : ($b < $a ? 'V' : '=') } @nums);
    $logger->debug("nums=(@nums) slope:$slope");

    # Extract sequences of AV or VA
    my @zigzag = $slope =~ m/( (?:AV)+A? | (?:VA)+V? )/gx;
    $logger->debug("zigzag = (@zigzag)");

    my $length = 1;
    if ( @zigzag )
    {
        $length += max( map { length($_) } @zigzag);
    }
    elsif ( $slope =~ m/[AV]/ )
    {
        $length += 1;
    }
    return $length;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(9, 4, 2, 10, 7, 8, 8, 1, 9), 5, "Example 1");
    is( task(1, 7, 4, 9, 2, 5          ), 6, "Example 2");
    is( task(1, 2, 3, 4, 5             ), 2, "Example 3");
    is( task(4, 4, 4                   ), 1, "Example 4");
    is( task(10, 20, 15, 12, 18        ), 3, "Example 5");
    is( task(4                         ), 1, "Single element");
    is( task(                          ), 0, "No element");
    is( task(9, 8, 7, 6, 5             ), 2, "Descending");

    done_testing;
}
