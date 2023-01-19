#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Equal Distribution
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers greater than or equal to zero, @list.
# Write a script to distribute the number so that each members are same.
# If you succeed then print the total moves otherwise print -1.
# Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]
# 1) You can only move a value of '1' per move
# 2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell
#
# Example 1: Input: @list = (1, 0, 5) Output: 4
#   Move #1: 1, 1, 4 (2nd cell gets 1 from the 3rd cell)
#   Move #2: 1, 2, 3 (2nd cell gets 1 from the 3rd cell)
#   Move #3: 2, 1, 3 (1st cell get 1 from the 2nd cell)
#   Move #4: 2, 2, 2 (2nd cell gets 1 from the 3rd cell)
#
# Example 2: Input: @list = (0, 2, 0) Output: -1
#   It is not possible to make each same.
#
# Example 3: Input: @list = (0, 3, 0) Output: 2
#   Move #1: 1, 2, 0 (1st cell gets 1 from the 2nd cell)
#   Move #2: 1, 1, 1 (3rd cell gets 1 from the 2nd cell)
#=============================================================================

use v5.36;

use List::Util qw/sum min all/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $lst = "@ARGV";
$lst =~ s/[[:punct:]]/ /g;

say equalDist( [ split ' ', $lst ] );

sub equalDist($list)
{
    my $len = scalar(@$list);
    my $target = sum($list->@*) / $len;

    say showList("_", "_", "_", $list), " target=$target" if $Verbose;

    if ( $target != int($target) )
    {
        say "Can't distribute evenly, target=$target" if $Verbose;
        return -1;
    }

    my $move = 0;

    # Push surpluses from left to right
    my $deficit = 0;
    for (my $i = 0 ; $i < $len-1 ; $i++ )
    {
        my $surplus = $list->[$i] - $target;

        if ( $surplus <= 0 )
        {
            $deficit -= $surplus;
            say showList($i, $i, 0, $list), " deficit=$deficit" if $Verbose;
            next;
        }

        # If we can satisfy our left neighbors, do that before
        # pushing stuff right that we'll have to push back later
        if ( $deficit > 0 )
        {
            my $moveLeft = min($surplus, $deficit);
            $move += $moveLeft;
            $surplus -= $moveLeft;
            $deficit -= $moveLeft;
            $list->[$i]   -= $moveLeft;
            $list->[$i-1] += $moveLeft;
            say showList($i, $i-1, $moveLeft, $list), " deficit=$deficit" if $Verbose;
            next if $surplus == 0;
        }
        $move += $surplus;
        $list->[$i]   -= $surplus;
        $list->[$i+1] += $surplus;
        say showList($i, $i+1, $surplus, $list), " deficit=$deficit" if $Verbose;
    }

    # Push surpluses from right to left
    for ( my $i = $len -1 ; $i > 0 ; $i-- )
    {
        if ( (my $surplus = $list->[$i] - $target) > 0 )
        {
            $move += $surplus;
            $list->[$i] -= $surplus;
            $list->[$i-1] += $surplus;
            say showList($i, $i-1, $surplus, $list) if $Verbose;
        }
    }
    say "Total moves: $move" if $Verbose;

    die showList(0,0,$move, $list), " FAILED" if $Verbose
                        && ! all { $_ == $target } $list->@*;

    return $move;
}

sub showList($from, $to, $count, $list)
{
    my $s;
    if    ( $from eq $to ) { $s .= "List:                    [" }
    elsif ( $from < $to )  { $s .= "Move $count from [$from] --> [$to]: ["; }
    else                   { $s .= "Move $count from [$from] <-- [$to]: ["; }

    for ( my $i = 0 ; $i < @$list ; $i++ )
    {
        if (  $from ne $to && $i == $from ) { $s .= " $list->[$i]- " }
        elsif ( $from ne $to && $i == $to ) { $s .= " $list->[$i]+ " }
        else                { $s .= " $list->[$i]  " }
    }
    $s .= "]"
}


sub runTest
{
    use Test2::V0;

    is( equalDist( [1,0,5] ),  4, "Example 1");
    is( equalDist( [0,2,0] ), -1, "Example 2");
    is( equalDist( [0,3,0] ),  2, "Example 3");
    is( equalDist( [10,0,0,0,0] ), 20, "Stack left");
    is( equalDist( [0,0,0,0,10] ), 20, "Stack right");
    is( equalDist( [0,0,10,0,0] ), 12, "Stack middle");
    is( equalDist( [3,3,3,4,2] ), 1, "Last move");
    is( equalDist( [5,3,4,4,4] ), 1, "First move");
    is( equalDist( [2,3,1,3,1] ), 2, "Little shuffle");
    is( equalDist( [2,1,3,1,3] ), 2, "Little shuffle take 2");
    is( equalDist( [2,0,2,0,6] ), 8, "Bigger shuffle");

    done_testing;
}

