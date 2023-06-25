#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 222 Task 2 Last Member 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of positive integers, @ints.
# Write a script to find the last member if found otherwise return 0.
# Each turn pick 2 biggest members (x, y) then decide based on the following
# conditions, continue this until you are left with 1 member or none.
#   a) if x == y then remove both members
#   b) if x != y then remove both members and add new member (y-x)
# Example 1: Input: @ints = (2, 7, 4, 1, 8, 1)
#           Output: 1
#   Step 1: pick 7 and 8, we remove both and add 1 => (2, 4, 1, 1, 1).
#   Step 2: pick 2 and 4, we remove both and add 2 => (2, 1, 1, 1).
#   Step 3: pick 2 and 1, we remove both and add 1 => (1, 1, 1).
#   Step 4: pick 1 and 1, we remove both => (1).
# Example 2: Input: @ints = (1)
#           Output: 1
# Example 3: Input: @ints = (1, 1)
#           Output: 0
#   Step 1: pick 1 and 1, we remove both and we left with none.
#=============================================================================

use v5.36;

use FindBin qw($Bin);
use lib "$FindBin::Bin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub lastMember($list)
{
    my @sorted = sort { $a <=> $b } @$list;

    while ( @sorted > 1 )
    {
        my @biggest = (pop @sorted, pop @sorted);
        if ( $biggest[0] != $biggest[1] )
        {
            push @sorted, $biggest[1] = $biggest[0];
        }
    }
    return scalar(@sorted);
}

sub runTest
{
    use Test2::V0;

    is( lastMember([2,7,4,1,8,1]) , 1, "Example 1");
    is( lastMember([1          ]) , 1, "Example 2");
    is( lastMember([1,1        ]) , 0, "Example 3");

    done_testing;
}

