#!/usr/bin/perl

# Peter Campbell Smith - 2022-04-18
# PWC 161 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# A pangram is a sentence or phrase that uses every letter in the English 
# alphabet at least once. For example, perhaps the most well known pangram is:
# Using the provided dictionary, generate at least one pangram.

# Blog: https://pjcs-pwc.blogspot.com/2022/04/abecedarian-words-and-pangrams.html

my ($dictionary, $done, $k, $last_word, $num_letter, $num_letters, $num_words, $ord_a, $pangram, $word,
	$num_chars, @best_words, @best_chars, $tries, @words);

# fetch dictionary
$dictionary = `curl -s -L https://github.com/manwar/perlweeklychallenge-club/raw/master/data/dictionary.txt`;

while ($dictionary =~ m|(.*?)\n|g) {
	$word = lc($1);
	chomp($word);
	push @words, lc($word);
}
$last_word = scalar @words;

$done = 2 ** 26 - 1;	# bitmap if all 26 letters have been found
$ord_a = ord('a');

# make 10 'random' pangrams
say qq[--- 10 random pangrams ---];

for $k (1 .. 10) {	
	($pangram, $num_words, $num_letters) = pangram();
	say qq[\nPangram $k:\n$pangram\n$num_words words, $num_letters letters];
}

# find the fewest words and letters from lots of tries
$tries = 10000;
say qq[\n--- Fewest words and letters from $tries tries ---];

@best_words = ('', 1000, 1000);
@best_chars = ('', 1000, 1000);

for $k (1 .. $tries) {
	($pangram, $num_words, $num_letters) = pangram();
	if ($num_words < $best_words[1]) {
		@best_words = ($pangram, $num_words, $num_letters);
	}
	if ($num_letters < $best_chars[2]) {
		@best_chars = ($pangram, $num_words, $num_letters);
	}
}

say qq[\nLeast words:\n$best_words[0]\n$best_words[1] words, $best_words[2] letters];
say qq[\nLeast letters:\n$best_chars[0]\n$best_chars[1] words, $best_chars[2] letters];
	
sub pangram {

	my ($bit, $letter, $num_chars, $num_words, $pangram, $pattern, 
		$target, $word, @letters);
	
	# generates a 'random' pangram
	
	# initialise
	$target = 0;   			# bitmap so far 
	$pangram = '';
	
	# loop over random words
	while ($word = $words[int(rand($last_word))]) {
		
		# split word into letters
		@letters = split(//, $word);
#		next if $#letters > 4;   # see blog about this line
		
		# create bitmap of this word
		$pattern = 0;
		for $letter (@letters) {
			$bit = ord($letter) - $ord_a;
			$pattern |= 2 ** $bit;
		}
		
		# if this word has letter(s) we don't have, add it to the pangram
		if ($pattern & ~ $target) {
			$pangram .= $word . ' ';
			$target |= $pattern;
			$num_words ++;
			$num_chars += $#letters + 1;
		}
		
		# have we got them all yet?
		last if $target == $done;
	}
	return($pangram, $num_words, $num_chars);
}


