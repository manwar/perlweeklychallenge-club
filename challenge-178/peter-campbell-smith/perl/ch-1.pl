#!/usr/bin/perl

# Peter Campbell Smith - 2022-08-15
# PWC 178 task 1

use v5.28;
use utf8;
use warnings;
use POSIX 'floor';

# Write a script to convert a given number (base 10) to quater-imaginary base number and vice-versa. 

# Blog: 

my (@tests, $test, $real_part, $imag_part, $result, $real, $imag, $qib);

@tests = ([5, 0], [0, 5], [4, 6], [35, 23], [-7, -10], [52, -77], [-1, 4]);
#          5       5i      4+6i    35+23i    -7-10i     52-77i     -1+4i

for $test (@tests) {
	$qib = to_qib(@$test);
	$result = from_qib($qib);
	say '';
}

sub to_qib {
	
	# converts a complex number with integer coefficients to a quater-imaginary base number
	
	my ($real, $imag, $real_part, $imag_part, $result);
	
	($real, $imag) = @_;
	
	# convert real part and -2 x imag part to qib numbers
	$real_part = quater_imag($real) . '.0';
	$imag_part = quater_imag(-$imag * 2);
	
	# right shift the imag part (so dividing it by 2i)
	$imag_part =~ m|(.*)(.)|;
	$imag_part = qq[$1.$2]; 
	
	# add the real and imag parts
	$result = quater_add($real_part, $imag_part);
	say qq[$real + ${imag}i = [$result]2i];
	return $result;
}
	
sub from_qib {
	
	# converts a quater-imaginary base number to a complex number with integer coefficients

	my ($qib, @digits, $real, $imag, $real_mult, $imag_mult, $hold, $digit);

	$qib = $_[0];
	
	# put the digits into an array
	@digits = split(//, $qib);
	
	# loop over the digits from least significant upwards
	$imag = 0;
	$real = 0;
	$real_mult = 0;   	# these are the contributions of the digit after the point
	$imag_mult = -0.5;
	for $digit (reverse @digits) {
		next if $digit eq '.';
		
		# add the (decimal) values of the digits to the answer
		$real += $real_mult * $digit;
		$imag += $imag_mult * $digit;
		
		# and get the real and imag contributions from the next digit
		$hold = $real_mult;
		$real_mult = -2 * $imag_mult;
		$imag_mult = 2 * $hold;
	}
	say qq[[$qib]2i = $real + ${imag}i];
}

sub quater_imag {
	
	# converts a real decimal number to a qib
	
	my ($number, $answer, $quotient, $remainder);
	
	# apply the 'Another conversion method' from Wikipedia
	$number = $_[0];
	$answer = '';
	
	# each division step contributes a remainder (0..3) and a following zero
	while (1) {
		($quotient, $remainder) = div_minus4($number);
		$answer = $remainder . '0' . $answer;
		$number = $quotient;
		last unless $number != 0;
	}
	
	# remove the trailing zero
	return substr($answer, 0, -1);
}

sub div_minus4 {  

	# divides argument by -4 such that the remainder is always +ve
	
	my ($dividend, $quotient, $remainder);
	
	$dividend = $_[0];
	$quotient = -floor($dividend / 4);
	$remainder = $dividend + 4 * $quotient;
	return ($quotient, $remainder);
}

sub quater_add {
	
	# adds 2 qib numbers of which the first is real and the second is imaginary
	# both have one digit after the point
	
	my ($real, $imag, $result, $j);
	
	# left pad them with lots of zeroes so that corresponding digits are in the same place in the string
	($real, $imag) = @_;
	$real = substr('00000000000000000000' . $real, -20);
	$imag = substr('00000000000000000000' . $imag, -20);
	
	# add them digit by digit
	for $j (0 .. 19) {
		if (substr($real, $j, 1) eq '.') {
			$result .= '.';
		} else {
			$result .= substr($real, $j, 1) + substr($imag, $j, 1);
		}
	}
	
	# get rid of the leading '0's
	$result =~ s|^0*||;
	return $result;
}
		