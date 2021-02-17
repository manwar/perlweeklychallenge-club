#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 100, Task #2 › Triangle Sum
#
# You are given triangle array.
# Write a script to find the minimum path sum from top to bottom.
#
# When you are on index i on the current row then you may move to either index
# i or index i + 1 on the next row.
#
# Example 1: Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
#            Output: 8
#
# Explanation: The given triangle
#
#           1
#          2 4
#         6 4 9
#        5 1 7 2
# The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
#=============================================================================

use strict;
use warnings;
use 5.020;
use experimental qw/ signatures /;

use Getopt::Long;
my $DoTest;
my $Verbose;
GetOptions('test' => \$DoTest, 'verbose' => \$Verbose);

use List::Util qw(min);

runTest() if $DoTest;

my $minSum;
sub walk($tree, $lastRow, $row, $col, $sum)
{
    say "WALK: lastRow=$lastRow, row=$row, col=$col, sum=$sum" if $Verbose;
    if ( $row == $lastRow )
    {
        $minSum = min( ($minSum //= $sum), $sum);
        say "LEAF: row=$row, col=$col, sum=$sum: minSum=$minSum" if $Verbose;
        return $sum;
    }

    walk($tree, $lastRow, $row+1, $col,   $sum + $tree->[$row+1][$col]  );
    walk($tree, $lastRow, $row+1, $col+1, $sum + $tree->[$row+1][$col+1]);

    return $sum;
}
sub triangleSum($tri)
{
    $minSum = undef;
    my $lastRow = @$tri - 1;

    if ( $lastRow > 0 )
    {
        walk($tri, $lastRow, 1, 0, $tri->[0][0] + $tri->[1][0]) ;
        walk($tri, $lastRow, 1, 1, $tri->[0][0] + $tri->[1][1]) ;
    }
    else
    {
        $minSum = $tri->[0][0];
    }

    return $minSum;
}

sub runTest
{
    use Test::More;

    for my $case (
        [  [ [9] ]  , 9 ],
        [  [ [2], [3,5] ]  , 5 ],
        [  [ [1], [2,4], [6,4,9]  ]            , 7 ],
        [  [ [1], [2,4], [6,4,9], [5,1,7,2] ]  , 8 ],
        [  [ [3], [3,1], [5,2,3], [4,3,1,3] ]  , 7 ],
                 )
    {
        is ( triangleSum($case->[0]), $case->[1] );
    }

    done_testing;
}

