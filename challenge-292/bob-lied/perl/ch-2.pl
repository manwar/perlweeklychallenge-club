#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 292 Task Zuma Game
#=============================================================================
# You are given a single row of colored balls, $row and a random number
# of colored balls in $hand.
# Here is the variation of Zuma game as your goal is to clear all of the
# balls from the board. Pick any ball from your hand and insert it in between
# two balls in the row or on either end of the row. If there is a group of
# three or more consecutive balls of the same color then remove the group of
# balls from the board. If there are no more balls on the board then you win
# the game. Repeat this process until you either win or do not have any more
# balls in your hand.
# 
# Write a script to minimum number of balls you have to insert to clear all
# the balls from the board. If you cannot clear all the balls from the board
# using the balls in your hand, return -1.
#
# Example 1 Input: $board = "WRRBBW", $hand = "RB"
#           Output: -1
#   It is impossible to clear all the balls. The best you can do is:
#   - Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
#   - Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
#   There are still balls remaining on the board, and you are out of balls.
#
# Example 2 Input: $board = "WWRRBBWW", $hand = "WRBRW"
#           Output: 2
#   To make the board empty:
#   - Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.
#   - Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.
#   2 balls from your hand were needed to clear the board.
#
# Example 3 Input: $board = "G", $hand = "GGGGG"
#           Output: 2
#   To make the board empty:
#   - Insert 'G' so the board becomes GG.
#   - Insert 'G' so the board becomes GGG. GGG -> empty.
#   2 balls from your hand were needed to clear the board.
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say zumba(@ARGV);


sub zumba($row, $hand)
{
    # Breadth-first search to find minimum length.
    my @queue = ( [ $row, $hand, 0 ] );

    while ( defined( my $try = shift @queue ) )
    {
        my ($board, $balls, $count) = $try->@*;
        $count++;

        for my $ball ( split(//, $balls) )
        {
            # Try to insert next to a matching group
            while ( $board =~ m/$ball+/g )
            {
                my $new = $board;
                substr($new, pos($board), 0, $ball);
                say "INSERT $ball at ", pos($board), " $new ($count)" if $Verbose;

                # Remove groups of 3 or more of any color
                while ( $new =~ s/(.)\1\1+//g )
                {
                    say "REDUCE $ball --> $new" if $Verbose;
                }

                return $count if $new eq "";

                push @queue, [ $new, substr($balls, 1), $count ];
            }
        }
    }
    return -1;
}

sub runTest
{
    use Test2::V0;

    is( zumba("WRRBBW", "RB"),      -1, "Example 1");
    is( zumba("WWRRBBWW", "WRBRW"),  2, "Example 2");
    is( zumba("G", "GGGGG"),         2, "Example 3");
    is( zumba("GGGGG", "G"),         1, "No moves necessary");
    is( zumba("GGGGG", "Z"),        -1, "No moves possible");

    done_testing;
}
