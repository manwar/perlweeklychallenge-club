#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-07
use utf8;     # Week 290 - task 2 - Luhn’s algorithm
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

luhns_algorithm('17893729974');
luhns_algorithm('4137 8947 1175 5904');
luhns_algorithm('4137 8974 1175 5904');
luhns_algorithm('3141 5926 5358 9796');

sub luhns_algorithm {
	
	my ($str, $data, $payload, $check_sum, $digit, $check_digit, $odd, $j);
	
	# get rid of non-digits
	$str = $_[0];
	$str =~ s|[^\d]||g;
	
	# strip payload
	($data, $payload) = $str =~ m|(\d+)(\d)|;
	
	# loop over digits from right to left
	$check_sum = 0;
	$odd = 1;
	for ($j = length($data) - 1; $j >= 0; $j --) {
		$digit = substr($data, $j, 1);
		
		# if an odd digit double and mod 10
		if ($odd) {
			$digit *= 2;
			$digit -= 9 if $digit >= 10;
		}
		$check_sum += $digit;
		$odd = 1 - $odd;
	}
	
	# get check digit
	$check_digit = 10 - (($check_sum - 1) % 10 + 1);
		
	say qq[\nInput:  \@str = '$_[0]'];
	say qq[Output: ] . ($check_digit == $payload ? 'true' : 'false') . qq[ (payload = $payload, check_digit = $check_digit)];
}
