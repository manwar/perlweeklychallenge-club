#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 223 Task 2 Box Coins
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array representing box coins, @box.
# Write a script to collect the maximum coins until you took out all boxes.
# If we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1].
# If $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.
# Example 1: Input: @box = (3, 1, 5, 8)
#           Output: 167
#   Step 1: pick box [i=1] and collected coins 3 * 1 * 5 => 15.
#           Boxes available (3, 5, 8).
#   Step 2: pick box [i=1] and collected coins 3 * 5 * 8 => 120.
#           Boxes available (3, 8).
#   Step 3: pick box [i=0] and collected coins 1 * 3 * 8 => 24.
#           Boxes available (8).
#   Step 4: pick box [i=0] and collected coins 1 * 8 * 1 => 8.
#           No more box available.
# Example 2: Input: @box = (1, 5)
#           Output: 10
#   Step 1: pick box [i=0] and collected coins 1 * 1 * 5 => 5.
#           Boxes available (5).
#   Step 2: pick box [i=0] and collected coins 1 * 5 * 1 => 5
#           No more box available.
#=============================================================================

use v5.36;

use Getopt::Long; my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $Max = 0;
sub _boxCoin($box, $total, $indent)
{
    # Assumes there is a 1 on each end
    return unless $box->$#* > 1;
    my $last = $box->$#*;

    for my $coin ( 1 .. $last-1 )
    {
        my $score = $box->[$coin-1] * $box->[$coin] * $box->[$coin+1];

        my $newTotal = $total + $score;
        $Max = $newTotal if $newTotal > $Max;

        say "${indent}[@$box] [$coin]=$box->[$coin], score=$score, total=", $newTotal if $Verbose;

        _boxCoin( [ $box->@[0..$coin-1], $box->@[$coin+1 .. $last] ], $total+$score, "$indent  " );
    }
}

sub boxCoins($box)
{
    $Max = 0;
    # Put a 1 on each end to handle edges
    _boxCoin( [ 1, $box->@*, 1 ], 0, "" );
    return $Max;
}

sub runTest
{
    use Test2::V0;

    is( boxCoins( [3,1,5,8] ), 167, "Example 1");
    is( boxCoins( [1,5    ] ),  10, "Example 2");
    is( boxCoins( [       ] ),   0, "Empty list");
    is( boxCoins( [  7    ] ),   7, "Singleton");
    is( boxCoins( [1,2    ] ),   4, "1,2");
    is( boxCoins( [2,1    ] ),   4, "2,1");
    is( boxCoins( [1,2,3  ] ),  12, "1,2,3");
    is( boxCoins( [3,2,1  ] ),  12, "3,2,1");
    is( boxCoins( [3,1,2  ] ),  15, "3,1,2");
    is( boxCoins( [1,2,3,4] ),  40, "1,2,3,4");
    is( boxCoins( [4,3,2,1] ),  40, "4,3,2,1");
    is( boxCoins( [2,4,3,1] ),  36, "2,4,3,1");

    done_testing;
}
