#!/usr/bin/env raku
use Test;

#|[
Task 2: Two out of Three
  - You are given three array of integers.
  - Write a script to return all the elements that are present in at least 2 out of 3 given arrays.
]
sub task2(@input where @input.elems == 3) {
	(@input[0] ∩ @input[1])
			∪ (@input[1] ∩ @input[2])
			∪ (@input[0] ∩ @input[2])
}

my @testcases2 = (
{input => ((1, 1, 2, 4), (2, 4), (4)   ), output => (2, 4).Set,    description=>"two elements"},
{input => ((4, 1),       (2, 4), (1, 2)), output => (1, 2, 4).Set, description=>"all elements"},
);

cmp-ok task2($_<input>), &[eqv], $_<output>, $_<description> for @testcases2;