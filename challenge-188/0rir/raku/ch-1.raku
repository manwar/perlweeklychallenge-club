#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
188-1: Divisible Pairs         Submitted by: Mohammad S Anwar

Given divisor $k, and a list of integers @list.  Find the count of pairs
in the list that satisfy the following rules:

The index pair (i, j) is eligible if and only if
a) 0 <= i < j < len(list)
b) list[i] + list[j] is evenly divisible by k

Input: @list = (4, 5, 1, 6), $k = 2
Output: 2

Input: @list = (1, 2, 3, 4), $k = 2
Output: 2

Input: @list = (1, 3, 4, 5), $k = 3
Output: 2

Input: @list = (5, 1, 2, 3), $k = 4
Output: 2

Input: @list = (7, 2, 4, 5), $k = 4
Output: 1
=end comment

sub divisible-pairs-count( Int $divisor, List $list --> Int) {
    my $len := $list.elems;

    ( grep { (@$list[ .key] + @$list[.value]) %% $divisor}, # cull req B from
      grep { .key < .value < $len},                    # cull req A from
      map { Pair.new( $_[0], $_[1])}, (^@$list).combinations: 2
    ).Int
}

sub MAIN () {
    my @Test =
        { list => (4, 5, 1, 6), k => 2, exp => 2, },
        { list => (1, 2, 3, 4), k => 2, exp => 2, },
        { list => (1, 3, 4, 5), k => 3, exp => 2, },
        { list => (5, 1, 2, 3), k => 4, exp => 2, },
        { list => (7, 2, 4, 5), k => 4, exp => 1, },
        { list => (4, 2, 5, 1, 6), k => 7, exp => 2, },
        { list => (9, 6, 7, 2, 4, 5, 8, 3 ), k => 2, exp => 12, },
        { list => (3, 9, 7, 17, 6), k => 7, exp => 0, },
    ;
    plan +@Test;
    for @Test -> %t {
        is divisible-pairs-count( %t<k>, %t<list>), %t<exp>,
                "K: %t<k>  List: %t<list> --> %t<exp>";
    }
    done-testing;
}
