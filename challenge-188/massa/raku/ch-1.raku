#!/usr/bin/env raku

=begin pod

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Divisible Pairs

    You are given list of integers C<@list> of size C<$n> and divisor C<$k>.

    Write a script to find out count of pairs in the given list that satisfies
    the following rules.

=begin code
    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k
=end code

=end pod

use Test;

is 2, divisible-pairs 2, (4, 5, 1, 6);
is 2, divisible-pairs 2, (1, 2, 3, 4);
is 2, divisible-pairs 3, (1, 3, 4, 5);
is 2, divisible-pairs 4, (5, 1, 2, 3);
is 1, divisible-pairs 4, (7, 2, 4, 5);
is 6, divisible-pairs 2, (2, 2, 2, 2);

done-testing;

sub divisible-pairs($k, @list) {
    @list.combinations(2)».sum.grep(* %% $k).elems
}

