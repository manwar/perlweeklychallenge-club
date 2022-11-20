#!/usr/bin/env raku

=begin pod

Week 191:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

Task #1: Twice Largest

    You are given list of integers, @list.

    Write a script to find out whether the largest item in the list
    is at least twice as large as each of the other items.

=end pod

use Test;

is twice-largest(<1 2 3 4>), -1, 'Example 1';
is twice-largest(<1 2 0 5>),  1, 'Example 2';
is twice-largest(<2 6 3 1>),  1, 'Example 3';
is twice-largest(<4 5 2 3>), -1, 'Example 4';

done-testing;

#
#
# METHOD

sub twice-largest(@list --> Int) {
    my Int $max = @list.sort.tail;
    for @list -> $i {
        next if $i == $max;
        ($i * 2 > $max) and return -1;
    }

    return 1;
}
