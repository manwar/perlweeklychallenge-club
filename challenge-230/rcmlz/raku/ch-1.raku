#!/usr/bin/env raku
use Test;

#|[
Task 1: Separate Digits
- You are given an array of positive integers.
- Write a script to separate the given array into single digits.
]
sub task1(@input) {
	@input.map( *.comb ).flat;
}

my @testcases = (
  {input => (1, 34, 5, 6),   output=> (1, 3, 4, 5, 6)},
  {input => (1, 24, 51, 60), output=> (1, 2, 4, 5, 1, 6, 0)},
);

is task1($_<input>), $_<output> for @testcases;