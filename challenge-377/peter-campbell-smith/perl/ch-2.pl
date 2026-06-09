#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-08
use utf8;     # Week 377 - task 2 - Prefix suffix
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

prefix_suffix('a', 'aba', 'ababa', 'aa');
prefix_suffix('pa', 'papa', 'ma', 'mama');
prefix_suffix('abao', 'ab');
prefix_suffix('abab', 'abab');
prefix_suffix(qw[a aa aaa aaaa aaaaa aaaaaa]);
prefix_suffix(qw[aba ababa]);

sub prefix_suffix {
	
	my (@strings, $count, $i, $j, $explain);
	
	# initialise
	@strings = @_;
	say qq[\nInput:  ('] . join(q[', '], @strings) . q[')];
	
	# sort by length
	@strings = sort {length($a) <=> length($b)} @strings;
	
	# loop over potential pairs
	$count = 0;
	for $i (0 .. $#strings) {
		for $j ($i + 1 .. $#strings) {
			
			# test for prefix and suffix match
			if (($strings[$j] . $strings[$j]) =~ 
				m|^$strings[$i].*$strings[$i]$|) {
				$count ++;
				$explain .= qq[$strings[$i] of $strings[$j], ];
			}
		}
	}		
		
	say qq[Output: $count] . ($count ? qq[ - ] . 
		substr($explain, 0, -2) : '');
}
