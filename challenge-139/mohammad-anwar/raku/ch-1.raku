#!/usr/bin/env raku

=begin pod

Week 139:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-139

Task #1: JortSort

    You are given a list of numbers.

    Write a script to implement JortSort. It should return true/false depending if the given list of numbers are already sorted.

=end pod

use Test;

is jortsort([1,2,3,4,5]), True,  'Example 1';
is jortsort([1,3,2,4,5]), False, 'Example 2';

done-testing;

#
#
# METHODS

sub jortsort(@n where @n.elems ~~ Int --> Bool) {

    my @s = @n.sort;
    for 0 .. @n-1 -> $i {
        return False if @n[$i] != @s[$i];
    }

    return True;
}
