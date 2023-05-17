#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Max Number 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of positive integers.
# Write a script to concatenate the integers to form the highest possible value.
# Example 1: Input: @list = (1, 23), 231
# Example 2: Input: @list = (10, 3, 2), 3210
# Example 3: Input: @list = (31, 2, 4, 10), 431210
# Example 4: Input: @list = (5, 11, 4, 1, 2), 542111
# Example 5: Input: @list = (1, 10), 110
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub maxNumber(@list)
{
    my @sorted = sort { "$b$a" cmp "$a$b" } @list;
    say "sorted: [@sorted]" if $Verbose;
    return 0 + join "", @sorted;
}

sub runTest
{
    use Test2::V0;

    is( maxNumber(1, 23         ),    231, 'Example 1');
    is( maxNumber(10, 3, 2      ),   3210, 'Example 2');
    is( maxNumber(31, 2, 4, 10  ), 431210, 'Example 3');
    is( maxNumber(5, 11, 4, 1, 2), 542111, 'Example 4');
    is( maxNumber(1, 10         ),    110, 'Example 5');
    is( maxNumber(1, 10, 100    ), 110100, 'Example 6');
    is( maxNumber(7,  0, 0      ),    700, 'With a 0');
    is( maxNumber(0,  0, 0      ),      0, 'All zero');

    done_testing;
}
