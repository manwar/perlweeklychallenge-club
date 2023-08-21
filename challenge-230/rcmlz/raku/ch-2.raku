#!/usr/bin/env raku
use Test;

#|[
Task 2: Count Words
- You are given an array of words made up of alphabetic characters and a prefix.
- Write a script to return the count of words that starts with the given prefix.
]
sub task2(%input) {
	my $prefix = %input<prefix>;
	%input<words>.grep( / ^ $prefix / ).elems;
}

my @testcases = (
  {input => { words=> ("pay", "attention", "practice", "attend"), prefix=>"xxx"}, output => 0},
  {input => { words=> ("pay", "attention", "practice", "attend"), prefix=>"at"},  output => 2},
  {input => { words=> ("janet", "julia", "java", "javascript"),   prefix=>"ja"},  output => 3},
);

is task2($_<input>), $_<output> for @testcases;