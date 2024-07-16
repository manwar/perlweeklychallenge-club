#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-15
use utf8;     # Week 278 - task 2 - Reverse word
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

reverse_word('challenge', 'e');
reverse_word('programming', 'a');
reverse_word('champion', 'b');
reverse_word('testing', 't');
reverse_word('multiplication', 'n');

sub reverse_word {
	
	my ($word, $char, $output);
	
	($word, $char) = @_;
	if ($word =~ m|(.*?$char)(.*)|) {
		$output = join('', sort(split(//, $1))) . $2;
	} else {
		$output = $word;
	}
	
	printf(qq[\nInput:  \$word = '%s', \$char = '%s'\n], $word, $char);
	printf(qq[Output: '%s'\n], $output);
}
