#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-15
use utf8;     # Week 378 - task 1 - Second largest digit
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

second_largest_digit('xy4mn7oo5');
second_largest_digit('999888');
second_largest_digit('21');
second_largest_digit('Weekly Challenge 378 - task 1 - 2026-06-15');
second_largest_digit('1');
second_largest_digit('q');
second_largest_digit('');

# bigger example
my $string;
$string .= substr('abcdefghijklmnopqrstuvwxyz0123456789', 
	rand(36), 1) for 0 .. 500;
second_largest_digit($string);

sub second_largest_digit {
	
	my ($string, @digits, $j);
	
	# initialise
	$string = $_[0];
	say qq[\nInput:  '$string'];
	
	# extract digits and reverse sort them 
	@digits = sort {$b <=> $a} grep {/\d/} split(//, $string);
	
	# find the first one less than $digits[0]
	for $j (1 .. $#digits) {
		if ($digits[$j] < $digits[0]) {
			say qq[Output: $digits[$j]];
			return;
		}
	}
	
	# else
	say qq[Output: -1];			
}
