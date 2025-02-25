#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 306 Task 2 Last Element
#=============================================================================
# You are given a array of integers, @ints.
# Write a script to play a game where you pick two biggest integers in
# the given array, say x and y. Then do the following:
# a) if x == y then remove both from the given array
# b) if x != y then remove x and replace y with (y - x)
# At the end of the game, there is at most one element left.
# Return the last element if found otherwise return 0.
# Example 1 Input: @ints = (3, 8, 5, 2, 9, 2)
#           Output: 1
#   Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
#   Step 2: pick 3 and 5 => (2, 2, 1, 2)
#   Step 3: pick 2 and 1 => (1, 2, 2)
#   Step 4: pick 2 and 1 => (1, 2)
#   Step 5: pick 1 and 2 => (1)
#
# Example 2 Input: @ints = (3, 2, 5)
#           Output: 0
#   Step 1: pick 3 and 5 => (2, 2)
#   Step 2: pick 2 and 2 => ()
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

say lastElem(@ARGV);

#=============================================================================
sub lastElem(@ints)
{
    @ints = sort { $b <=> $a } @ints;
    while ( @ints > 1 )
    {
        if ( $ints[0] == $ints[1] )
        {
            shift @ints; shift @ints;
            next;
        }
        else
        {
            $ints[1] = $ints[0] - $ints[1];
            shift @ints;
            @ints = sort { $b <=> $a } @ints;
        }
    }
    return scalar(@ints);
}

sub runTest
{
    use Test2::V0;

    is( lastElem(3,8,5,2,9,2), 1, "Example 1");
    is( lastElem(3,2,5), 0, "Example 2");

    done_testing;
}
