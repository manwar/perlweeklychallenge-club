#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-02-05
use utf8;     # Week 255 task 2 - Most frequent word
use strict;   # Peter Campbell Smith
use warnings; 
binmode STDOUT, ':utf8';

most_frequent_word('Joe hit a ball, the hit ball flew far 
	after it was hit by Joe.', 'hit');

most_frequent_word('Perl and Raku belong to the same 
	family. Perl is the most popular language in the 
	weekly challenge.', 'the');
	
most_frequent_word('banned banned allowed allowed allowed',
	'banned');

sub most_frequent_word {
	
	my ($p, $q, $w, $most, $word, %times);
	
	# initialise
	$p = shift;
	$w = lc(shift);
	say qq[\nInput:  \$p = '$p'\n        \$w = '$w'];
	$p = lc($p);
	
	# do it
	$most = 0;
	$times{$w} = 0;
	
	# split $p into words and discard any that eq $w
	while ($p =~ m|([a-z]+)|gs) {
		$q = $1;
		
		# record one use of this word
		$times{$q} ++;
		next if $q eq $w;
		
		# if more than the previous best, make it the new best
		if ($times{$q} > $most) {
			$most = $times{$q};
			$word = $q;
			
		# if the same as the previous best, record it as equal best	
		} elsif ($times{$q} == $most) {
			$word .= qq[, $q];
		}
	}
	
	# deliver the answer
	say qq[Output: '$word' - $most times];
	say qq[        '$w' (banned) - $times{$w} times];
}
