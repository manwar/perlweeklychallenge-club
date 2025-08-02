#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 257 Task 1 Smaller than Current
#=============================================================================
# You are given a array of integers, @ints.
# Write a script to find out how many integers are smaller than current
# i.e. foreach ints[i], count ints[j] < ints[i] where i != j.
# Example 1 Input: @ints = (5, 2, 1, 6)
#           Output: (2, 1, 0, 3)
# Example 2 Input: @ints = (1, 2, 0, 3)
#           Output: (1, 2, 0, 3)
# Example 3 Input: @ints = (0, 1)
#           Output: (0, 1)
# Example 4 Input: @ints = (9, 4, 9, 2)
#           Output: (2, 1, 2, 0)
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

say "(", join(", ", stc(@ARGV)->@*), ")";

sub stc(@ints)
{
    # Sort in descending order
    my @sorted = sort { $b <=> $a } @ints;

    my %smaller = map { $_ => 0 } @ints;
    while ( defined(my $one = shift @sorted) )
    {
        # Skip over duplicate values;
        while ( @sorted && $sorted[0] == $one ) { shift @sorted }
        $smaller{$one} = scalar(@sorted);
    }
    return [ @smaller{ @ints } ];
}

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub runTest
{
    use Test2::V0;

    is( stc(5,2,1,6), [2,1,0,3], "Example 1");
    is( stc(1,2,0,3), [1,2,0,3], "Example 2");
    is( stc(0,1    ), [0,1    ], "Example 3");
    is( stc(9,4,9,2), [2,1,2,0], "Example 4");
    is( stc(9,9,9,9), [0,0,0,0], "All same");

    done_testing;
}
