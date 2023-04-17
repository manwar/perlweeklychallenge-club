#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 212 Task 2 Rearrange Groups 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers and group size greater than zero.
# Write a script to split the list into equal groups of the given size where
# integers are in sequential order. If it can’t be done then print -1.
# Example 1: Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
#           Output: (1,2,3), (1,2,3), (5,6,7)
# Example 2: Input: @list = (1,2,3) and $size = 2
#           Output: -1
# Example 3: Input: @list = (1,2,4,3,5,3) and $size = 3
#           Output: (1,2,3), (3,4,5)
# Example 4: Input: @list = (1,5,2,6,4,7) and $size = 3
#           Output: -1
#=============================================================================

use v5.36;

use List::Util qw(min);

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub rearrange($list, $grpsize)
{
    return [] if ( (scalar(@$list) % $grpsize) != 0 );

    my %available;
    $available{$_}++ for $list->@*;
    my @output;
    
    for ( 0 .. ($list->$#* / $grpsize ) )
    {
        my @group;
        my $start = min grep { $available{$_} > 0 } keys %available;
        for my $seq ( $start .. ($start + $grpsize - 1) )
        {
            if ( $available{$seq} )
            {
                push @group, $seq;
                $available{$seq}--;
            }
        }
        if ( @group == $grpsize )
        {
            push @output, [ @group ];
        }
        else
        {
            return []
        }
    }

    return \@output;
}

sub runTest
{
    use Test2::V0;

    is( rearrange([1,1,1,2,2,2],       2), [[1,2],[1,2],[1,2]], "Example 0");
    is( rearrange([1,2,3,5,1,2,7,6,3], 3), [ [1,2,3],[1,2,3],[5,6,7]], "Example 1");
    is( rearrange([1,2,3],             2), [],                  "Example 2");
    is( rearrange([1,2,4,3,5,3],       3), [[1,2,3],[3,4,5]],   "Example 3");
    is( rearrange([1,5,2,6,4,7],       3), [],                  "Example 4");
    is( rearrange([1,2,3,6,7,8],       3), [[1,2,3],[6,7,8]],   "No overlap");

    done_testing;
}

