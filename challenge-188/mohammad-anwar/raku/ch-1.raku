#!/usr/bin/env raku

=begin pod

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Divisible Pairs

    You are given list of integers @list of size $n and divisor $k.

    Write a script to find out count of pairs in the given list that
    satisfies the following rules.

    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k

=end pod

use Test;

is count-divisibles([4, 5, 1, 6], 2), 2, 'Example 1';
is count-divisibles([1, 2, 3, 4], 2), 2, 'Example 2';
is count-divisibles([1, 3, 4, 5], 3), 2, 'Example 3';
is count-divisibles([5, 1, 2, 3], 4), 2, 'Example 4';
is count-divisibles([7, 2, 4, 5], 4), 1, 'Example 5';

done-testing;

#
#
# METHOD

sub count-divisibles($list, Int $k --> Int) {
    my Int $count = 0;
    my Int $size  = $list.elems;
    for ^$size -> $i {
        for $i ^..^ $size -> $j {
            $count++ if ($list.[$i] + $list.[$j]) %% $k;
        }
    }

    return $count;
}
