#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 214 Task 2 Collect Points 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of numbers.
# You will perform a series of removal operations. For each operation, you
# remove from the list N (one or more) equal and consecutive numbers, and add
# to your score N × N.  Determine the maximum possible score.
# Example 1: Input: @numbers = (2,4,3,3,3,4,5,4,2) Output: 23
#   We see three 3's next to each other so let us remove that first and
#   collect 3 x 3 points.  So now the list is (2,4,4,5,4,2).
#   Let us now remove 5 so that all 4's can be next to each other and
#   collect 1 x 1 point.  So now the list is (2,4,4,4,2).
#   Time to remove three 4's and collect 3 x 3 points.  Now the list is (2,2).
#   Finally remove both 2's and collect 2 x 2 points.
#   So the total points collected is 9 + 1 + 9 + 4 => 23.
# Example 2: Input: @numbers = (1,2,2,2,2,1) Output: 20
#   Remove four 2's first and collect 4 x 4 points.  Now the list is (1,1).
#   Finally remove the two 1's and collect 2 x 2 points.
#   So the total points collected is 16 + 4 => 20.
# Example 3: Input: @numbers = (1) Output: 1
# Example 4: Input: @numbers = (2,2,2,1,1,2,2,2) Output: 40
#   Remove two 1's = 2 x 2 points.  Now the list is (2,2,2,2,2,2).
#   Then reomove six 2's = 6 x 6 points.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say collectPoints(@ARGV);

# Return pairs of [offset, length] for each span of equal values in list
sub findSpan($list)
{
    my $listLength = @$list;
    if    ( $listLength == 0 ) { return [] }
    elsif ( $listLength == 1 ) { return [ [0, 1] ] }

    my @span;

    my $beg = my $end = 0;
    my $len = 1;
    while ( $end < $listLength )
    {
        while ( $end < $list->$#* && $list->[$end+1] == $list->[$end] )
        {
            $end++;
            $len++;
        }
        push @span, [ $beg, $len ];
        $beg = ++$end;
        $len = 1;
    }
    return \@span;
}

# Recursive function to do depth-first searches for best score
sub _collect($list, $scoreSoFar, $indent)
{
    say "$indent _collect[ $list->@* ], $scoreSoFar" if $Verbose;

    my $numLen = @$list;
    if    ( $numLen == 0 ) { return $scoreSoFar; }
    elsif ( $numLen == 1 ) { return $scoreSoFar + 1; }
    elsif ( $numLen == 2 )
    {
        return $scoreSoFar + ($list->[0] == $list->[1] ? 4 : 2 );
    }

    my $spanList = findSpan($list);

    my $bestScore = 0;
    for my $span ( @$spanList )
    {
        my ($beg, $length) = $span->@*;
        my $score = $length * $length;

        # Remove the span from the list and recurse
        my @copy = $list->@*;
        if ( $Verbose )
        {
            my @rmv = $list->@[$beg .. $beg+$length-1];
            splice(@copy, $beg, $length, ('*')x$length);
            say "$indent RMV [@rmv], copy=[@copy] score=$score";
        }

        splice(@copy, $beg, $length);

        $score = _collect(\@copy, $score, "  $indent");
        if ( $score  > $bestScore )
        {
            $bestScore = $score;
            say "$indent BEST: $bestScore" if $Verbose;
        }
    }
    return $scoreSoFar + $bestScore;
}

sub collectPoints(@numbers)
{
    return _collect(\@numbers, 0, "");
}

sub runTest
{
    use Test2::V0;

    is( findSpan( [9]       ), [ [0,1] ],             "findSpan singleton");
    is( findSpan( [4,5,6]   ), [ [0,1],[1,1],[2,1] ], "unique");
    is( findSpan( [4,4,5,6] ), [ [0,2],[2,1],[3,1] ], "leading span");
    is( findSpan( [4,5,6,6] ), [ [0,1],[1,1],[2,2] ], "trailing span");
    is( findSpan( [4,5,5,6] ), [ [0,1],[1,2],[3,1] ], "middle span");

    is( collectPoints(2), 1, "Singleton");
    is( collectPoints(2,3), 2, "Small");
    is( collectPoints(2,2), 4, "Pair");
    is( collectPoints(2,2,2), 9, "Triplet");
    is( collectPoints(2,4,3,3,3,4,5,4,2), 23, "Example 1");
    is( collectPoints(1,2,2,2,2,1      ), 20, "Example 2");
    is( collectPoints(1                ),  1, "Example 3");
    is( collectPoints(2,2,2,1,1,2,2,2  ), 40, "Example 4");

    done_testing;
}

