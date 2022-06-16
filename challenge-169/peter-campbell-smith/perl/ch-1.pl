#!/usr/bin/perl

# Peter Campbell Smith - 2022-06-13
# PWC 169 task 1

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util qw[factor];

# Write a script to generate first 20 Brilliant Numbers, which are numbers having just two prime factors,
# and those are the same length.

# Blog at https://pjcs-pwc.blogspot.com/2022/06/brilliant-and-achilles.html

my ($test, @pf, $result, $count);

# loop till done
for ($test = 1, $count = 0; $count < 20; $test ++) {
	@pf = factor($test);
	
	# test for brilliance
	next unless (scalar @pf == 2 and length($pf[0]) == length($pf[1]));
	
	# accumulate answers
	$result .= qq[$test, ];
	$count ++;
}

# tell the world
say substr($result, 0, -2);
