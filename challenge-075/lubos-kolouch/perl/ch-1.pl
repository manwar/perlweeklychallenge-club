#!/usr/bin/env perl
use strict;
use warnings;
# Perl weekly challenge 075 Task 1 - Coins sum


sub count {

    my ($coins, $target_sum) = @_;

    my @ways = (0) x $target_sum;
    $ways[0] = 1;

    for my $coin_pos (0..scalar @$coins - 1) {
        for my $j (0..$target_sum) {
            $ways[$j] += $ways[$j - $coins->[$coin_pos]] if $coins->[$coin_pos] <= $j;
        }
    }

    return $ways[$target_sum];
}

use Test::More;

is(count([1, 2, 4], 6), 6, 'Test case 1, 2, 4 and 6');
is(count([1, 5, 10], 12), 4, 'Test case 1, 5, 10 and 12');
done_testing;
