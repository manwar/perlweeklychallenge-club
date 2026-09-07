#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/386/1

use v5.26;    # The Weekly Challenge - 2026-08-10
use utf8;     # Week 386 - task 1 - Reverse base
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

reverse_base('101010', 2);
reverse_base('EEADEE', 16);
reverse_base('755', 8);
reverse_base('1BRJB', 36);
reverse_base('7MyqL', 64);
reverse_base('TheWeeklyChallenge', 62);
reverse_base('', 44);
reverse_base('11111', 1);
reverse_base('181', 8);
reverse_base('-', 10);

sub reverse_base {
	
	my ($string, $base, $j, $c, %values, $decimal, $rest, $digit);
	
	# initialise
	($string, $base) = @_;
	say qq[\nInput:  \$number = '$string', \$base = $base];
	unless ($base > 1 and $base < 65) {
		say qq[Output: base must be between 2 and 64]; return;
	}
	
	# build values table
	$j = 0;
	for $c ('0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/') {
		$values{$c} = $j ++;
	}
	
	# convert string to decimal
	$decimal = 0;
	while ($string ne '') {
		($digit, $rest) = $string =~ m|^(.)(.*)$|g;
		if (not defined $values{$digit} or $values{$digit} >= $base) {
			say qq[Output: invalid digit '$digit']; return;
		}
		$decimal = $decimal * $base + $values{$digit};
		$string = $rest;
	}
	say qq[Output: $decimal base 10];
}
