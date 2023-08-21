#!/usr/bin/env raku
use Test;

#|[
Task 1: Lexicographic Order
 - You are given an array of strings.
 - Write a script to
      - delete element which is not lexicographically sorted (forwards or backwards)
        and
      - (return the count of deletions.)
]
sub task1(@input) {
	@input.grep( -> $e { $e.comb.sort.join eqv ( $e | $e.flip ) });
}

my @testcases1 = (
{input => ("abc", "bce"),        output=> ("abc", "bce"), description=>"all elements are lexicographically sorted."},
{input => ("abc", "bce", "cae"), output=> ("abc", "bce"), description=>"'cae' is the only element which is not lexicographically sorted."},
{input => ("yxz", "cba", "mon"), output=> ("cba"),        description=>"'yxz' and 'mon' are not lexicographically sorted."},
);

is task1($_<input>), $_<output>, $_<description> for @testcases1;