#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-30
# PWC 167 task 2

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Complex;

# Implement subroutine gamma() using the Lanczos approximation method.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/prime-eprim-mepri-imepr-rimep-and-gamma.html

# Translated from the Python code at https://en.wikipedia.org/wiki/Lanczos_approximation

my (@p, $EPSILON, $j);

@p = (676.5203681218851,
    -1259.1392167224028,
    771.32342877765313,
    -176.61502916214059,
    12.507343278686905,
    -0.13857109526572012,
    9.9843695780195716e-6,
    1.5056327351493116e-7);

$EPSILON = 1e-7;

# some test cases
for $j (3, 5, 7, 1.9, 2.1, 50, 0.6, 0.5, 0.4) {
	say qq[gamma($j) = ] . gamma($j);
}

sub drop_imag {
	
	# removes the imaginary part if arg < 10**-7
	my $z = shift;
    if (abs(Im($z)) <= $EPSILON) {
        $z = Re($z);
	}
    return $z;
}

sub gamma {
	
	# implements Lanczos approximation method
	my ($i, $t, $x, $y, $z);
	$z = shift;
	
    # reflects value if arg < 0.5
	if (Re($z) < 0.5) {
        $y = pi / (sin(pi * $z) * gamma(1 - $z));
		
    # the basic algorithm
	} else {
        $z -= 1;
        $x = 0.99999999999980993;
        for $i (0 .. scalar(@p) - 1) {
			$x += $p[$i] / ($z + $i + 1);
		}
        $t = $z + scalar(@p) - 0.5;
        $y = sqrt(2 * pi) * $t ** ($z + 0.5) * exp(-$t) * $x;
	}
    return drop_imag($y);
}
