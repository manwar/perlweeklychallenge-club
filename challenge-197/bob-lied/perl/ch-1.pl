#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# Perl Weekly Challenge Week 197, Task 1 Move Zero
#
# You are given a list of integers, @list.
# Write a script to move all zero, if exists, to the end while maintaining
# the relative order of non-zero elements.
# Example 1 Input:  @list = (1, 0, 3, 0, 0, 5)
#          Output: (1, 3, 5, 0, 0, 0)
# Example 2 Input: @list = (1, 6, 4)
#          Output: (1, 6, 4)
# Example 3 Input: @list = (0, 1, 0, 2, 0
#          Output: (1, 2, 0, 0, 0)
# 
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub moveZero(@list)
{
    my @noZero = grep { $_ != 0 } @list;
    return [ @noZero, (0) x ( scalar(@list)-scalar(@noZero) ) ];
}

sub runTest
{
    use Test::More;

    is_deeply( moveZero(1,0,3,0,0,5), [1,3,5,0,0,0], "Example 1");
    is_deeply( moveZero(1,6,4      ), [1,6,4      ], "Example 2");
    is_deeply( moveZero(0,1,0,2,0  ), [1,2,0,0,0  ], "Example 3");
    is_deeply( moveZero(0          ), [0          ], "Example 3");

    done_testing;
}

