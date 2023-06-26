#!/usr/bin/env perl

# You are given an array representing box coins, @box.
# 
# Write a script to collect the maximum coins until you took out all boxes. If
# we pick box[i] then we collect the coins $box[i-1] * $box[i] * $box[i+1]. If
# $box[i+1] or $box[i-1] is out of bound then treat it as 1 coin.
# 
# Example 1:
# 
# Input: @box = (3, 1, 5, 8)
# Output: 167
# 
# Step 1: pick box [i=1] and collected coins 3 * 1 * 5 => 15.  Boxes available (3, 5, 8).
# Step 2: pick box [i=1] and collected coins 3 * 5 * 8 => 120. Boxes available (3, 8).
# Step 3: pick box [i=0] and collected coins 1 * 3 * 8 => 24.  Boxes available (8).
# Step 4: pick box [i=0] and collected coins 1 * 8 * 1 => 8.   No more box available.
# 
# Example 2:
# 
# Input: @box = (1, 5)
# Output: 10
# 
# Step 1: pick box [i=0] and collected coins 1 * 1 * 5 => 5. Boxes available (5).
# Step 2: pick box [i=0] and collected coins 1 * 5 * 1 => 5. No more box available.

use strict;
use warnings;
use feature qw(state);
use Test::More;
use Data::Dumper;

my $cases = [
    [3, 1, 5, 8],
    [1, 5],
];

sub box_coins
{
    state $sum = 0;
    sub box_coins_2
    {
        my $l = shift;
        my $s = shift;

        for(my $i=0; $i<@$l; ++$i) {
            my @l = @$l;
            my $v = $s + (($i == 0 ? 1 : $l[$i-1]) * $l[$i] * ($i == $#l ? 1 : $l[$i+1]));
            splice(@l, $i, 1);
            box_coins_2(\@l, $v);
        }
        #print "called with: @$l -- $s\n";
        $sum = $s if $s > $sum;
        return $sum;
    }
    $sum = 0;
    box_coins_2(@_);
}

is(box_coins($cases->[0], 0), 167, '[3, 1, 5, 8]');
is(box_coins($cases->[1], 0), 10,  '[1, 5]');
done_testing();

exit 0;
