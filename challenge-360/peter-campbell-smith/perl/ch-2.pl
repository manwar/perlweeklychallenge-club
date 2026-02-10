#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-09
use utf8;     # Week 360 - task 2 - Word sorter
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

word_sorter('The quick brown fox');
word_sorter('Hello    World!   How   are you?');
word_sorter('Hello');
word_sorter('I have 2 apples and 3 bananas!');
word_sorter('one two three, one two three');
word_sorter('');
word_sorter('justoneword');

sub word_sorter {
	
	my ($sentence, %words, $key, $output, $i);
	
	# initialise
	$sentence = $_[0];
	
	# make eg $words{fred} = 'Fred'
	$words{lc($1) . ++ $i} = $1 while $sentence =~ m|([^\s]+)|g;
	
	# sort by key and concatenate values
	$output = '';
	for $key (sort{$a cmp $b} keys %words) {
		$output .= $words{$key} . ' ';
	}
	
	say qq[\nInput:  '$sentence'];
	say qq[Output: '] . substr($output, 0, -1) . q['];
}
