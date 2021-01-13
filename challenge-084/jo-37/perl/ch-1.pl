#!/usr/bin/perl

use 5.012;
use Test2::V0;
use Math::Utils 'copysign';

# Reverse the decimal representation of given numbers into signed
# long (32-bit) values.  Return zero for a result not fitting.
# This sub handles a list of numbers.
sub reverse_l {
	map $_ * (unpack('l', pack 'l', $_) == $_),
		map copysign(scalar(reverse abs int), $_), @_;
}

is [reverse_l  1234],          [4321], 'Example 1';
is [reverse_l -1234],         [-4321], 'Example 2';
is [reverse_l  1231230512],       [0], 'Example 3';
is [reverse_l -8463847412],  [-2**31], 'negative limit';
is [reverse_l  7463847412], [2**31-1], 'positive limit';
is [reverse_l -9463847412],       [0], 'below negative limit';
is [reverse_l  8463847412],       [0], 'above positive limit';
is [reverse_l  074],              [6], 'accept octal';
is [reverse_l  470],             [74], 'do not generate octal';
is [reverse_l  0xf0],            [42], 'accept hex';
is [reverse_l  123.456],        [321], 'ignore part after decimal point';
is [reverse_l -0],                [0], 'signless zero';
is [reverse_l 1e9 + 2, -1e9 - 2, 1e9 + 3, -1e9 - 3],
	[2e9 + 1, -2e9 - 1, 0, 0], 'list input';

done_testing;

# vi:ts=4:
