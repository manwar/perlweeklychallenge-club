

#!/usr/bin/env raku

=begin pod

Week 191:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

Task #2: Cute List

    You are given an integer, 0 < $n <= 15.

    Write a script to find the number of orderings of numbers that form a cute list.

    With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for every entry, indexed with a base of 1, either

=begin code

    1) $list[$i] is evenly divisible by $i
    or
    2) $i is evenly divisible by $list[$i]

=end code

=end pod

use Test;

is 2, cute-list 2;
is 3, cute-list 3;
is 8, cute-list 4;

done-testing;

subset Valid of Int where 0 < * ≤ 15;

sub cute-list(Valid \n) {
  + (1 .. n).permutations.grep: -> @list {
    @list.pairs.map({ (.key + 1) %% .value || .value %% (.key + 1) }).all.so
  }
}
