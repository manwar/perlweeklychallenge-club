#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 182 Task 1 Max Index
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers.
# Write a script to find the index of the first biggest number in the list.
# Example 1: Input: @n = (5, 2, 9, 1, 7, 6)
#           Output: 2 (as 3rd element in the list is the biggest number)
# Example 2: Input: @n = (4, 2, 3, 1, 5, 0)
#           Output: 4 (as 5th element in the list is the biggest number)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

use Scalar::Util qw/looks_like_number/;

my @list = grep { looks_like_number($_) }  @ARGV;

my $mi = maxIndex(@list);
print "maxIndex(@list) = " if $Verbose;
print $mi;
print " (list[$mi]=$list[$mi])" if $Verbose;
print "\n";

sub maxIndex(@list)
{
    my $max = $list[0];
    my $indexOfMax = 0;
    for ( my $i = 1; $i < @list ; $i++ )
    {
        if ( $list[$i] > $max )
        {
            $max = $list[$i];
            $indexOfMax = $i
        }
    }
    return $indexOfMax;
}

sub runTest
{
    use Test2::V0;

    is( maxIndex(5,2,9,1,7,6), 2, "Example 1");
    is( maxIndex(4,2,3,1,5,0), 4, "Example 1");
    is( maxIndex(9,2,5,1,7,6), 0, "At 0");
    is( maxIndex(6,2,5,1,7,9), 5, "At end");
    is( maxIndex(7,7,7,7,7,7), 0, "Multiple");

    done_testing;
}

