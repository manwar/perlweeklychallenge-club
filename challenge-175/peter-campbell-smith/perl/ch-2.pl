#!/usr/bin/perl

# Peter Campbell Smith - 2022-07-25
# PWC 175 task 2

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');
use Time::Local qw(timelocal_posix);

# Write a script to generate first 20 Perfect Totient Numbers. 

# Blog: https://pjcs-pwc.blogspot.com/2022/07/dates-and-more-recursively-defined.html

my ($trial, $sum, $number, $tc, $target, $found, $string, @tc);

# loop up from 2
$target = 20;
$found = 0;
TRIAL: for $trial (2 .. 10000) {
	
	$sum = 0;   
	$number = $trial;
	
	# loop over totients
	while (1) {
		$tc = defined $tc[$number] ? $tc[$number] :  # if we've calculated it already
			totient_count($number);                  # or calculate it if not
		$sum += $tc;
		next TRIAL if $sum > $trial;   # give up as we've already exceeded $trial
		last if $tc == 1;              # summation has converged to 1
		$number = $tc;                 # and if it hasn't get the tc of the tc
	}
	
	# save if we have a reault
	next TRIAL unless $sum == $trial;
	$string .= qq[$sum, ];
	last if ++ $found == $target;
}
say qq[The first $target perfect totient numbers are:\n] . substr($string, 0, -2);

sub totient_count {
	
	# counts the mutually primes less than the argument
	
	my ($number, $j, $count);
	$number = $_[0];
	
	$count = 0;
	for $j (1 .. $number - 1) {
		$count++ if gcd($j, $number) == 1;   # a and b are mutually prime if their gcd is 1
	}
	$tc[$number] = $count;   # cache this for future use
	return $count;
}
				
sub gcd {
	
	# calculates greatest common divisor of $a and $b

    my ($a, $b) = @_;
    return 0 == $b ? $a : gcd($b, $a % $b);
}
		

