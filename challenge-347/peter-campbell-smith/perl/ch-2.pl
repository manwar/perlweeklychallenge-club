#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-10
use utf8;     # Week 347 - task 2 - Format phone number
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

format_phone_number('1-23-45-6');
format_phone_number('1234');
format_phone_number('12 345-6789');
format_phone_number('123 4567');
format_phone_number('123 456-78');
format_phone_number('02072221212');

sub format_phone_number {
	
	my ($phone, $output, $length);
	
	# initialise
	$phone = shift;
	say qq[\nInput:  '$phone'];
	$phone =~ s|[^[0-9]||g;
	
	# groups of 3
	while (length($phone) > 4) {
		$output .= substr($phone, 0, 3) . '-';
		$phone = substr($phone, 3);
	}
	
	# and the rest
	$output .= length($phone) == 4 
		? substr($phone, 0, 2) . '-' . substr($phone, 2, 2) 
		: $phone;
	
	say qq[Output: '$output'];
}
