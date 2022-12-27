#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 197 Task 2 Wiggle Sort
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# You are given a list of integers, @list.
# Write a script to perform Wiggle Sort on the given list.
# Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….
#
# Example 1 Input: @list = (1,5,1,1,6,4)
#          Output: (1,6,1,5,1,4)
#
# Example 2 Input: @list = (1,3,2,2,3,1)
#          Output: (2,3,1,3,1,2)


# 
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub wiggleSort(@list)
{
    my @sl = sort { $a <=> $b } @list;

    # Subtract one for 0-based arrays
    my $midpoint = int( scalar(@sl) / 2 ) - 1;
    my @bottom = reverse @sl[0..$midpoint];
    my @top    = reverse splice(@sl, $midpoint+1);

    my @result;
    while ( @bottom && @top )
    {
        push @result, (shift @bottom), (shift @top);
    }
    push @result, @top if @top;  # Odd-sized lists
    return \@result;
}

sub runTest
{
    use Test::More;

    is_deeply( wiggleSort(1,5,1,1,6,4), [1,6,1,5,1,4], "Example 1");
    is_deeply( wiggleSort(1,3,2,2,3,1), [2,3,1,3,1,2], "Example 2");
    is_deeply( wiggleSort(1,3,2,2,3,1,4), [2,4,1,3,1,3,2], "Odd");

    done_testing;
}

