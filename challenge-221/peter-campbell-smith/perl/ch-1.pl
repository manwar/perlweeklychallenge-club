#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-06-12
use utf8;     # Week 221 task 1 - Good strings
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

good_strings(['cat', 'bt', 'hat', 'tree'], 'atach');
good_strings(['hello', 'world', 'challenge'], 'welldonehopper');
good_strings([qw(A string is good if it can be formed by characters from chars each character can be used only once)], 
	'abcdefghijklmnopqrstuvwxyz');
good_strings(['one', 'two', 'three'], 'xyz');

sub good_strings {
	
	my (@words, $chars, $letter, %letters, $word, $length, $explain, %all_letters);
	
	@words = @{$_[0]};
	$chars = lc($_[1]);
	$length = 0;
	$explain = '';
	
	# split $chars into individual letters
	for $letter (split('', $chars)) {
		$all_letters{$letter} ++;
	}
	
	WORD: for $word (@words) {
		
		# unused letters
		%letters = %all_letters;
		
		# disregard words that have any letters not in $chars
		for $letter (split('', lc($word))) {
			next WORD unless $letters{$letter};
			$letters{$letter} --;
		}
		
		# we have a good word
		$length += length($word);
		$explain .= qq[$word + ];
	}
	
	say qq[\nInput:  \@words = ('] . join(qq[', '], @words) . qq['), \$chars = '$chars'];
	say qq[Output: $length = ] . substr($explain, 0, -2);
	
}

