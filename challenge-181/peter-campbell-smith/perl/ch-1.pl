#!/usr/bin/perl

# Peter Campbell Smith - 2022-09-05
# PWC 181 task 1

use v5.28;
use utf8;
use warnings;

# You are given a paragraph. Write a script to order each sentence alphanumerically 
# and print the whole paragraph.

# Blog: https://pjcs-pwc.blogspot.com/2022/09/alphabetical-and-days-hotter-sentences.html

my ($input, $sentence, @words, $line_length, $word, $paragraph);

$input = q[All he could think about was how it would all end. There was
    still a bit of uncertainty in the equation, but the basics
    were there for anyone to see. No matter how much he tried to
    see the positive, it wasn't anywhere to be seen. The end was
    coming and it wasn't going to be pretty.];
	
# loop over sentences
$line_length = 0;
while ($input =~ m|(.+?)\.|gs) {
	$sentence = $1;
	
	# extract words in next sentence and sort them
	@words = ();
	while ($sentence =~ m|([a-z']+)|gi) {
		push(@words, $1);
	}
	@words = sort {lc($a) cmp lc($b)} @words;
	
	# output the words with line breaks to keep lines under 60 characters
	for $word (@words) {
		if ($line_length + length($word) > 59) {
			$paragraph .= qq[\n];
			$line_length = 0;
		}			
		$paragraph .= $word . ' ';
		$line_length += length($word) + 1;
	}
	$paragraph =~ s| $|. |;
}

# and print the result
say $paragraph;
	