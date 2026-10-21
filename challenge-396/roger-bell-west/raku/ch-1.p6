#! /usr/bin/raku

use Test;

plan 5;

is-deeply(finishingorder([3, 1, 4, 2, 5], [1, 4, 2]), [1, 4, 2], 'example 1');
is-deeply(finishingorder([5, 4, 3, 2, 1], [1, 3, 5]), [5, 3, 1], 'example 2');
is-deeply(finishingorder([2, 4, 1, 3], [1, 2, 3, 4]), [2, 4, 1, 3], 'example 3');
is-deeply(finishingorder([4, 1, 3, 2], [3]), [3], 'example 4');
is-deeply(finishingorder([1, 3, 2, 6, 5, 4], [1, 2, 3]), [1, 3, 2], 'example 5');

sub finishingorder(@order, @friends) {
    my %wanted = Set(@friends);
    @order.grep({%wanted{$_}:exists}).Array;
}
