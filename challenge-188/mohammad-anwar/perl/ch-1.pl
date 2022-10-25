#!/usr/bin/perl

=head1

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Divisible Pairs

    You are given list of integers @list of size $n and divisor $k.

    Write a script to find out count of pairs in the given list that
    satisfies the following rules.

    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k

=cut

use v5.36;
use Test2::V0;

is count_divisibles([4, 5, 1, 6], 2), 2, 'Example 1';
is count_divisibles([1, 2, 3, 4], 2), 2, 'Example 2';
is count_divisibles([1, 3, 4, 5], 3), 2, 'Example 3';
is count_divisibles([5, 1, 2, 3], 4), 2, 'Example 4';
is count_divisibles([7, 2, 4, 5], 4), 1, 'Example 5';

done_testing;

#
#
# METHOD

sub count_divisibles($list, $k) {
    my $count = 0;
    my $size  = scalar @$list;
    for (my $i = 0; $i < $size; $i++) {
        for (my $j = $i + 1; $j < $size; $j++) {
            if (($list->[$i] + $list->[$j]) % $k == 0) {
                $count++;
            }
        }
     }

    return $count;
}
