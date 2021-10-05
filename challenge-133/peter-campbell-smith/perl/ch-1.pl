#!/usr/bin/perl

# Peter Campbell Smith - 2021-10-05
# PWC 133 task 1

use strict;
use warnings;

# Find the integer square root of a +ve integer, ie the largest integer whose square
# does not exceed the given number.

# This is a simple binary chop but it works in milliseconds up to some pretty large
# numbers.

my ($n, $low, $high, $odd, $try);

$n = 123456;
chomp $n;

$low = 1;    # answer can't be less than this
$high = $n;  # or more than this

while (1) {
	
	# get a trial answer which is the average of $low and $high (rounded up)
	$odd = ($low + $high) & 1 ? 1 : 0;   # because we aren't allowed to use int()
	$try = ($low + $high + $odd) / 2;
	
	# if the trial's square is larger than n, set the new $high to the trial value
	if ($try**2 > $n) {
		$high = $try;
		
	# or if it is less than or equal, set the new $low to the trial value
	} else {
		$low = $try;
	}
	
	# and finish when $low is just 1 less than $high
	last if $high == $low + 1;
}

print qq[$n input\n$low answer\n] . $low**2 . qq[ = answer**2\n] . $high**2 . qq[ = (answer + 1)**2\n];
