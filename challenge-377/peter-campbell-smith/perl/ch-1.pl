#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-08
use utf8;     # Week 377 - task 1 - Reverse existence
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

reverse_existence('abcba');
reverse_existence('racecar');
reverse_existence('abcd');
reverse_existence('banana');
reverse_existence('xx');
reverse_existence('x');
reverse_existence('');

# 1000 random chars from set of 160
my $s;
$s .= chr(0xc0 + rand(160)) for 1 .. 1000; 
reverse_existence($s);

sub reverse_existence {
	
	my ($string, $reverse, $j, $substring);
	$string = $_[0];
	say qq[\nInput:  '$string'];
	
	# initialise
	$reverse = reverse($string);
	for $j (0 .. length($string) - 2) {
		$substring = substr($string, $j, 2);
		
		# does substring exist in reversed string?
		next unless $reverse =~ m|$substring|;
		say qq[Output: true - '$substring']; 
		return;
	}
	say qq[Output: false];
}
