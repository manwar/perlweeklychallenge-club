#!/usr/bin/perl

# Peter Campbell Smith - 2022-06-06
# PWC 168 task 1

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util 'is_prime';
use Math::BigInt lib => 'GMP';

# The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is the 
# sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ….)
# A Perrin prime is a number in the Perrin sequence which is also a prime number.
# Calculate the first 13 Perrin Primes.
# f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977]

# Blog at https://pjcs-pwc.blogspot.com/2022/06/more-funny-numbers-and-very-big-one.html

my (@perrin, $j, $result, $count);

# initialise
@perrin = (3, 0, 2);
$result = qq[, 2, 3, ];
$count = 2;

# calculate perrin primes until 13 unique ones found
for $j (3 .. 9999) {
	
	# get next term
	$perrin[$j] = Math::BigInt->new($perrin[$j - 2]);
	$perrin[$j]->badd($perrin[$j - 3]);
	
	# no good unless prime and not already seen
	next unless is_prime($perrin[$j]);
	next if $result =~ m|, $perrin[$j],|;
	
	# add to results
	$result .= qq[$perrin[$j], ];
	last if $count ++ == 12;
}

# deliver the answer
say qq[f($count) = ] . substr($result, 2, -2);
