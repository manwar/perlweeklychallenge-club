

#!/usr/bin/env raku

=begin pod

Week 191:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

Task #1: Twice Largest

    You are given list of integers, @list.

    Write a script to find out whether the largest item in the list is at least
    twice as large as each of the other items.

=end pod

use Test;

is False, twice-largest <1 2 3 4>;
is True,  twice-largest <1 2 0 5>;
is True,  twice-largest <2 6 3 1>;
is False, twice-largest <4 5 2 3>;

done-testing;

sub twice-largest(@list) {
  my @li = @list».Int.sort(-*);
  [&&] @li[0] X≥ @li[1..*].map(2 × *)
}


