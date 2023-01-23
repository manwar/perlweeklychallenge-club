#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 200 Task 1 Arithmetic Slice
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to find out all Arithmetic Slices for the given array of
# integers.  An integer array is called arithmetic if it has at least 3
# elements and the differences between any three consecutive elements are the same.
#
# Example 1 Input: @array = (1,2,3,4) Output: (1,2,3), (2,3,4), (1,2,3,4)
# Example 2 Input: @array = (2) Output: () as no slice found.
#
# Example 1 implies that we should get every sub-slice of length at least 3
# and that output order should have shorter sequences first
#=============================================================================

use v5.36;

use List::Util qw/all/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

use constant MINLENGTH => 3;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

die "All args should be numeric" unless all { $_ =~ m/-?\d+/ } @ARGV;

my $answer = aslice(@ARGV); # Should validate all numbers
say join(", ", map { "(". join(",", $_->@*) .")" } $answer->@*);

sub aslice(@list)
{
    my @result = ();
    while ( @list >= MINLENGTH )
    {
        my $diff = $list[1] - $list[0];

        for ( my $i = 2; $i < @list && $list[$i] - $list[$i-1] == $diff ; $i++ )
        {
            # Push every sub-slice that is at least MINLENGTH long
            push @result, [ @list[0..$i] ] if $i >= (MINLENGTH -1 );
        }
        shift @list;
    }
    return [ sort { scalar(@$a) <=> scalar(@$b) } @result ];
}

sub runTest
{
    use Test2::V0;

    is( aslice( 1,2,3,4 ), [ [1,2,3], [2,3,4], [1,2,3,4] ],  "Example 1");
    is( aslice( 2       ), [ ],                              "Example 2");
    is( aslice( 1,2,4,6,9,15,20,25,30,37 ),
        [ [2,4,6], [15,20,25], [20,25,30], [15,20,25,30] ],  "Bigger list, more diffs");
    is( aslice( 2,3,5,8,13,21 ), [],                         "No runs of 3");
    is( aslice( 3,6,4,7,10 ), [[4,7,10]],                    "Non-monotonic");
    is( aslice( 9,3,1,-1 ), [ [3,1,-1] ],                    "Negative difference");

    done_testing;
}

