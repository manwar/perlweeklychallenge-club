#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 214 Task 1 Rank Score 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of scores (>=1).
# Write a script to rank each score in descending order. First three will get
# medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the
# ranking number.
# Using the standard model of giving equal scores equal rank,
# then advancing that number of ranks.
# Example 1 Input: @scores = (1,2,4,3,5) Output: (5,4,S,B,G)
# Example 2 Input: @scores = (8,5,6,7,4) Output: (G,4,B,S,5)
# Example 3 Input: @list   = (3,5,4,2)   Output: (B,G,S,4)
# Example 4 Input: @scores = (2,5,2,1,7,5,1) Output: (4,S,4,6,G,S,6)
#=============================================================================

use v5.36;

use FindBin qw($Bin);
use lib "$FindBin::Bin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(",", rankScore(@ARGV)->@*), ")";

sub rankScore(@scoreList)
{
    return [] unless @scoreList;

    # Record position of each score if it was sorted descending.
    # Example:               [0] [1] [2] [3] [4]
    #          @scoreList = ( 1   2   4   3   5 )
    #      -->  @position = ( 4   3   1   2   0 )
    my @position = sort { $scoreList[$b] <=> $scoreList[$a] } 0 .. $#scoreList;

    # The colors or places that will be assigned.
    my @rank = ( qw(G S B), 4 .. (@scoreList) );
    my $r = 0;  # Index into @rank

    # In a copy of the scores, replace each score by its medal or rank.
    my @ranked = @scoreList;

    # The first position is always gold.
    my $place = $position[0];
    $ranked[ $place ] = $rank[$r];

    # Move through consecutive pairs of positions to see when to switch
    # rank colors.
    for my $index ( 1 .. $#position )
    {
        my $next = $position[$index];
        if ( $scoreList[$next] < $scoreList[$place] )
        {
            # Lower score, so advance rank
            $r = $index;
        }
        $ranked[$next] = $rank[$r];
        $place = $next;
    }
    return \@ranked;
}

sub runTest
{
    use Test2::V0;

    is( rankScore(1,2,4,3,5),     [ qw(5 4 S B G) ],     "Example 1");
    is( rankScore(8,5,6,7,4),     [ qw(G 4 B S 5) ],     "Example 2");
    is( rankScore(3,5,4,2),       [ qw(B G S 4) ],       "Example 3");
    is( rankScore(2,5,2,1,7,5,1), [ qw(4 S 4 6 G S 6) ], "Example 4");
    is( rankScore(2,7,7,1,7,5,1), [ qw(5 G G 6 G 4 6) ], "Gold only");
    is( rankScore(3,5    ),       [ qw(S G    ) ],       "Two players");

    done_testing;
}

