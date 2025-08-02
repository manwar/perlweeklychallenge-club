#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-07
use utf8;     # Week 329 - task 2 - Nice string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

nice_string('YaaAho');
nice_string('cC');
nice_string('A');
nice_string('ABCDEedcbaZABCDEedcbaa');

# longer example
my (@chars, $string);
@chars = (('A' .. 'I'),('a' .. 'i'));
$string .= $chars[int(rand(18))] for 0 .. 50;
nice_string($string);

sub nice_string {
	
	my ($string, $c, $best, $longest, $s, $t, $try);
	
	# initialise
	$string = shift;
	$c = length($string);
	$best = '';
	$longest = 0;
	
	# loop over starting points
	for $s (0 .. $c - 2) {
		
		# loop up to remaining length
		for $t (0 .. $c - $s) {
			next unless $t >= $longest;
			$try = substr($string, $s, $t);
			
			# nicest so far?
			if (is_nice($try)) { 
				$best = $try;
				$longest = $t;
			}
		}
	}
	
	say qq[\nInput:  '$string'];
	say qq[Output: '$best'];
}

sub is_nice {
	
	my ($string, @chars, $c, $C);
	
	# initialise
	$string = shift;
	@chars = split('', $string);
	
	# check for nicety
	for $c (@chars) {
		$C = $c gt 'Z' ? uc($c) : lc($c);
		return 0 unless $string =~ m|$C|;
	}
	return 1;
}
