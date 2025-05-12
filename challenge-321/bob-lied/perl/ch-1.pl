#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 321 Task 1 Distinct Average
#=============================================================================
# You are given an array of numbers with even length.  Write a script to
# return the count of distinct average. The average is calculate by removing
# the minimum and the maximum, then average of the two.
# Example 1 Input: @nums = (1, 2, 4, 3, 5, 6)
#           Output: 1
#   Step 1: Min = 1, Max = 6, Avg = 3.5
#   Step 2: Min = 2, Max = 5, Avg = 3.5
#   Step 3: Min = 3, Max = 4, Avg = 3.5
#   The count of distinct average is 1.
#
# Example 2 Input: @nums = (0, 2, 4, 8, 3, 5)
#           Output: 2
#   Step 1: Min = 0, Max = 8, Avg = 4
#   Step 2: Min = 2, Max = 5, Avg = 3.5
#   Step 3: Min = 3, Max = 4, Avg = 3.5
#   The count of distinct average is 2.
#
# Example 3 Input: @nums = (7, 3, 1, 0, 5, 9)
#           Output: 2
#   Step 1: Min = 0, Max = 9, Avg = 4.5
#   Step 2: Min = 1, Max = 7, Avg = 4
#   Step 3: Min = 3, Max = 5, Avg = 4
#   The count of distinct average is 2.
#=============================================================================

use v5.40;


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

say distAvg(@ARGV);

#=============================================================================
sub distAvg(@ints)
{
    my %average;
    @ints = sort { $a <=> $b } @ints;
    while ( @ints )
    {
        # We can skip the division for the average. It's a constant factor
        # of 2, and we're only looking for distinct values;

        # my $min = shift @ints;    # Remove minimum;
        # my $max = pop @ints;      # Remove maximum;

        $average{ (shift @ints)+(pop @ints) } = true;
    }
    return scalar keys %average;
}

sub runTest
{
    use Test2::V0;

    is( distAvg(1,2,4,3,5,6), 1, "Example 1");
    is( distAvg(0,2,4,8,3,5), 2, "Example 2");
    is( distAvg(7,3,1,0,5,9), 2, "Example 1");

    done_testing;
}
