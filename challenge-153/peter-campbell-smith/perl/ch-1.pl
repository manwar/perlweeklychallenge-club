#!/usr/bin/perl

# Peter Campbell Smith - 2022-02-21
# PWC 153 task 1

use v5.28;
use strict;
use utf8;

# Write a script to compute Left Factorials of 1 to 10. Please refer OEIS A003422 for more information.
# The OEIS reference says !n = Sum_{k=0..n-1} k!
# So !n = !(n-1) + (n-1)!

my ($n, $string, @lf, @fac);

# assume !1 and 1!
$lf[1] = 1;
$fac[1] = 1;
$string = qq[1, ];

# calculate the rest as per the third comment line above
for $n (2 .. 10) {
	$lf[$n] = $lf[$n - 1] + $fac[$n - 1];
	$fac[$n] = $fac[$n - 1] * $n;
	$string .= qq[$lf[$n], ];
}
say substr($string, 0, -2);
