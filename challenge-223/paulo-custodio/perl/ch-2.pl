#!/usr/bin/env perl

# Challenge 223
#
# Task 2: Box Coins
# Submitted by: Mohammad S Anwar
# You are given an array representing box coins, @box.
#
# Write a script to collect the maximum coins until you took out all boxes.
# If we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1].
# If $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.
#
#
# Example 1:
# Input: @box = (3, 1, 5, 8)
# Output: 167
#
# Step 1: pick box [i=1] and collected coins 3 * 1 * 5 => 15.  Boxes available (3, 5, 8).
# Step 2: pick box [i=1] and collected coins 3 * 5 * 8 => 120. Boxes available (3, 8).
# Step 3: pick box [i=0] and collected coins 1 * 3 * 8 => 24.  Boxes available (8).
# Step 4: pick box [i=0] and collected coins 1 * 8 * 1 => 8.   No more box available.
# Example 2:
# Input: @box = (1, 5)
# Output: 10
#
# Step 1: pick box [i=0] and collected coins 1 * 1 * 5 => 5. Boxes available (5).
# Step 2: pick box [i=0] and collected coins 1 * 5 * 1 => 5. No more box available.

use Modern::Perl;

my @box = @ARGV;
my $max = 0;
collect_max(\$max, 0, @box);
say $max;

sub collect_max {
    my($max, $sum, @box) = @_;

    if (@box <= 1) {
        $sum += $box[0] if @box;
        if ($$max < $sum) {
            $$max = $sum;
        }
        return;
    }
    else {
        for my $i (0 .. $#box) {
            my $collect = collect($i, @box);
            my @new_box = (@box[0..$i-1], @box[$i+1..$#box]);
            collect_max($max, $sum+$collect, @new_box);
        }
    }
}

sub collect {
    my($i, @box) = @_;
    my $collect = 1;
    $collect *= $box[$i-1] if $i-1 >= 0;
    $collect *= $box[$i];
    $collect *= $box[$i+1] if $i+1 < @box;
    return $collect;
}


