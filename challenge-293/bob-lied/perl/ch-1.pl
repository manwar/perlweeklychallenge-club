#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 293 Task 1 Similar Dominos
#=============================================================================
# You are given a list of dominos, @dominos.  Write a script to return the
# number of dominoes that are similar to any other domino.
# $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if
# either (a = c and b = d) or (a = d and b = c).
# Example 1 Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
#           Output: 2 (Similar Dominos: $dominos[0], $dominos[1])
# Example 2 Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
#           Output: 3 (Similar Dominos: $dominos[0], $dominos[1], $dominos[3])
#=============================================================================

use v5.40;
use List::Util qw/sum0/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Usage: $0  1,3  3,1  2,4  6,8
say similar( map { [ split(/,/, $_) ] } @ARGV );


sub similar(@dominos)
{
    my %count;
    while ( defined( my $tile1 = shift @dominos ) )
    {
        my @d = $tile1->@*;
        @d = ($d[1], $d[0]) if $d[1] < $d[0];

        $count{ "[$d[0],$d[1]]" }++;
    }
    if ( $Verbose ) { say "$_ => $count{$_}" for sort keys %count;}
    return sum0 grep { $_ > 1 } values %count;
}

sub runTest
{
    use Test2::V0;

    is( similar([1,3],[3,1],[2,4],[6,8]      ), 2, "Example 1");
    is( similar([1,2],[2,1],[1,1],[1,2],[2,2]), 3, "Example 2");

    done_testing;
}
