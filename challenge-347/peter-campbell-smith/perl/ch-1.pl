#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-10
use utf8;     # Week 347 - task 1 - Format date
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

format_date('15th Jan 2025');
format_date('22nd Feb 2025');
format_date('1st Jan 1900');
format_date('31st Dec 2100');
format_date('10th Nov 2025');

sub format_date {
	
	my ($string, $output, %mo, $d, $m, $y, $i);
	
	# initialise
	$string = shift;
	%mo = (Jan => 1, Feb => 2, Mar => 3, Apr => 4, May => 5, Jun => 6,
		Jul => 7, Aug => 8, Sep => 9, Oct => 10, Nov => 11, Dec => 12);
		
	# do it
	if (($d, $m, $y) = $string =~ m|(\d{1,2}).+?([a-z]{3}).+?(\d{4})|i) {
		$output = sprintf('%04d-%02d-%02d', $y, $mo{$m}, $d);
	} else {
		$output = 'illegal format';
	}	
	
	say qq[\nInput:  '$string'];
	say qq[Output: $output];
}
