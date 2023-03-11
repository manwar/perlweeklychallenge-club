#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-20

use v5.28;
use utf8;
use warnings;

# We are given an array of words and asked to write a script to print all the words in the 
# array that can be typed using the letters on only one row of the keyboard.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/207/1

linear_words('Hello','Alaska','Dad','Peace');
linear_words('OMG','Bye');
linear_words('typewriter', 'zmncbxvz', 'shakalshas');
linear_words(qw[We are given an array of words and asked to write a script to print all the words in the 
	array that can be typed using the letters on only one row of the keyboard]);
	
sub linear_words {

	my (@test, $word, $result);
	$result = '';
	
	# loop over words and save those that are monolinear
	for $word (@_) {
		$result .= qq['$word', ] if $word =~ m¦^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$¦i;
	}
	
	say qq[\nInput:  ('] . join(q[', '], @_) . qq[')];
	say qq[Output: (] . substr($result, 0, -2) . qq[)];
}	
