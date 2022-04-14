#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-30
# PWC 158 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# You are given a positive number, $n < 10. Write a script to generate english 
# text sequence starting with the English cardinal representation of the given 
# number, the word 'is' and then the English cardinal representation of the count 
# of characters that made up the first word,
# followed by a comma. Continue until you reach four.

my (@numbers, $n, $string, $length, $k, $this, $next);

@numbers = qw(x one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen
	seventeen eighteen nineteen twenty);

for $n (1 .. $#numbers) {
	$string = '';
	
	$this = $n;
	for $k (1 .. 20) {
		$next = length($numbers[$this]);
		$string .= qq[$numbers[$this] is $numbers[$next], ];
		last if $next == 4;
		$this = $next;
	}
	$string = ucfirst($string);
	say qq[\nInput:  \$n = $n\nOutput: ${string}four is magic.];
}
