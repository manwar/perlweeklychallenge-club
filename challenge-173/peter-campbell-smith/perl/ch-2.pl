#!/usr/bin/perl

# Peter Campbell Smith - 2022-07-11
# PWC 173 task 2

use v5.28;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ':utf8');
use Math::BigInt;

# Write a script to generate first 10 members of Sylvester's sequence.  Sylvester's sequence is 
# an integer sequence in which each term of the sequence is the product of all the previous terms, plus one.

# Blog: https://pjcs-pwc.blogspot.com/2022/07/aesthetics-and-fast-growing-sequence.html

my (@sylvester, $j);

# first 2 terms are given
$sylvester[0] = Math::BigInt->new(2);
$sylvester[1] = Math::BigInt->new(3);

# loop over 10 terms
for $j (0 .. 9) {
	if ($j > 1) {
		$sylvester[$j] = Math::BigInt->new(0)  # zero
			->badd($sylvester[$j - 1])         # plus the preceding term
			->bsub(Math::BigInt->new(1))       # minus 1 (to get product of all terms up to preceding one)
			->bmul($sylvester[$j - 1])         # times the preceding one
			->badd(Math::BigInt->new(1));      # plus 1
	}
	say qq[sylvester[$j] = ] . $sylvester[$j]->bstr();
}
