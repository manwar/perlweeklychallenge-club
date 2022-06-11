#!/usr/bin/perl

# Peter Campbell Smith - 2022-04-18
# PWC 161 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# An abecedarian word is a word whose letters are arranged in alphabetical order. 
# Output or return a list of all abecedarian words in the dictionary, sorted in 
# decreasing order of length.

# And as requested:
# Oh no, a bent hoop, a gory bus, a dirty floor, all beg for deep effort.

# Blog: https://pjcs-pwc.blogspot.com/2022/04/abecedarian-words-and-pangrams.html

my ($dictionary, $k, $word, @letters, %results, $line, $word_count, $result_count, $abcd); 

# fetch dictionary
$dictionary = `curl -s -L https://github.com/manwar/perlweeklychallenge-club/raw/master/data/dictionary.txt`;

# loop over dictionary words
WORD: while ($dictionary =~ m|(.*)?\n|g) {
	$word = $1;
	$word_count ++;
	
	# split word into array of letters
	@letters = split(//, $word);
	
	# single letter words are ok
	if ($#letters == 1) {
		$results{98 . $word} = 1;   # key is so that they sort correctly
		
	# check successive pairs
	} else {
		for $k (0 .. $#letters - 1) {
			next WORD if ($letters[$k + 1] lt $letters[$k]);
		}
		
		# result!
		$results{(99 - $#letters) . $word} = 1;
	}
}

# print them out in the specified order
say qq[\nAbecedarian words from dictionary:];
for $k (sort keys %results) {
	$line .= substr($k, 2, 99)  . ' ';
	if (length $line > 100) {
		say $line;
		$line = '';
	}
	$abcd ++;
}
say $line if $line;

say qq[\nFrom $word_count words found $abcd that are abecedarian (] .
	(int($abcd / $word_count * 10000) / 100) . '%)';


