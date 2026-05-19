#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-18
use utf8;     # Week 374 - task 1 - Count vowel
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

count_vowel('aeiou');
count_vowel('aaeeeiioouu');
count_vowel('aeiouuaxaeiou');
count_vowel('uaeiou');
count_vowel('aeioaeioa');

sub count_vowel {
	
	my ($string, @result, @subs, $sub, $sub_length, $s, $f, $subsub);
	
	# initialise
	$string = lc($_[0]);
	say qq[\nInput:  '$string'];
	@result = ();
	
	# quick discards
	for ('a', 'e', 'i', 'o', 'u') {
		if ($string !~ m|$_|) {
			say qq[Output: ()];
			return;
		}
	}
	
	# segment string at non-vowels
	push @subs, $1 while $string =~ m|([aeiou]+)|g;
	SUB: for $sub (@subs) {
		
		# eliminate substring if too short or missing a vowel
		$sub_length = length($sub);
		next SUB if $sub_length < 5;
		
		# look for string of vowels
		for $s (0 .. $sub_length - 5) {
			SUBSUB: for $f (4 .. $sub_length - 1) {
				$subsub = substr($sub, $s, $f - $s + 1);
				for ('a', 'e', 'i', 'o', 'u') {
					next SUBSUB if $subsub !~ m|$_|;
				}
				push @result, $subsub;
			}
		}
	}
	say qq[Output: ('] . join(q[', '], @result) . q[')];
}
