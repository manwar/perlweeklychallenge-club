#!/usr/bin/env perl vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
#ch-1.pl Perl Weekly Challenge 210 Task 1  Kill And Win
#=============================================================================
#Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers.
# Write a script to get the maximum points. You are allowed to take out (kill)
# any integer and remove from the list. However if you do that then all
# integers exactly one-less or one-more would also be removed. Find out the
# total of integers removed.
# Example 1 Input: @int = (2, 3, 1) Output: 6
#   First we delete 2 and that would also delete 1 and 3. So the maximum
#   points we get is 6.
# Example 2 Input: @int = (1, 1, 2, 2, 2, 3) Output: 11
#   First we delete 2 and that would also delete both the 1's and the 3.
#   Now we have (2, 2).  Then we delete another 2 and followed by the third
#   deletion of 2. So the maximum points we get is 11.
#=============================================================================

use v5.36;

use List::Util qw/sum0/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my $BestScore = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say killAndWin( [ @ARGV ] );

# Make one move in @list by removing $position.
# Returns a pair: the score from removing this element, and a reference
# to a list with the element and its neighbors killed.
sub killScore($position, @list)
{
    # Remove the element at $position
    my $val = $list[$position];
    splice(@list, $position, 1);

    # Evaluate the score for one above and one below
    my $score = $val + sum0 grep { $_ == ($val-1) || $_ == ($val+1) } @list;

    # Shrink the list by removing those elements
    my $newList = [ grep { not ($_ == ($val-1) || $_ == ($val+1) ) } @list ];

    return ($score, $newList);
}

# Recursive function to make a move and then play again with what's left.
sub _play($position, $list, $score, $indent)
{
    say "${indent}_play($position, [@$list], $score)" if $Verbose;

    my $len = @$list;

    # Base case to end recursion.
    return if ( $len == 0 );

    # Small optimization when we're near the end of the recursion.
    if ( $len == 1 )
    {
        $score += $list->[0];
        $BestScore = $score if $score > $BestScore;
        return;
    }

    # Make this move at $position, evaluate the score.
    my $s;
    ($s, $list) = killScore($position, @$list);
    say "${indent}killScore: $s, [@$list]" if $Verbose;
    $len = @$list;
    $score += $s;
    $BestScore = $score if $score > $BestScore;

    # Recursively play the possibilities with a smaller list.
    _play($_, $list, $score, "  $indent") for 0 .. $#{$list}
}

sub killAndWin($list)
{
    _play($_, $list, 0, "") for 0 .. $#{$list};
    return $BestScore;
}

sub runTest
{
    use Test2::V0;

    my @list;
    my $newList;
    my $score;
    @list = ( 2, 3, 1 );
    ($score, $newList) = killScore(0, @list);
    is( $score, 6, "Score for kill 0");
    is( $newList, [], "List after kill 0");

    @list = ( 2, 3, 1 );
    ($score, $newList) = killScore(1, @list);
    is( $score, 5, "Score for kill 1");
    is( $newList, [1], "List after Kill 1");

    @list = ( 2, 3, 1 );
    ($score, $newList) = killScore(2, @list);
    is( $score, 3, "Score for kill 2");
    is( $newList, [3], "List after Kill 2");

    @list = (1,1,2,2,2,3);
    ($score, $newList) = killScore(1, @list);
    is( $score, 7, "Score for long kill 1");
    is( $newList, [1,3], "List after long kill 1");

    @list = (1,1,2,2,2,3);
    ($score, $newList) = killScore(2, @list);
    is( $score, 7, "Score for long kill 2");
    is( $newList, [2,2], "List after long kill 2");

    is( killAndWin([2,3,1]),        6, "Example 1");
    is( killAndWin([1,1,2,2,2,3]), 11, "Example 2");
    is( killAndWin([1,2,3,4,5,6]), 21, "Example 3");
    is( killAndWin([6,5,4,3,2,1]), 21, "Example 4");

    done_testing;
}

