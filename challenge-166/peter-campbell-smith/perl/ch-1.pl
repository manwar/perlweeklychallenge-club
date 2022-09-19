#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-23
# PWC 166 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# Write a program that will read from a dictionary and find 2- to 8-letter words 
# that can be “spelled” in hexadecimal, with the addition of the following letter substitutions:
# o -> 0, i -> 1, l -> 1, s -> 7, t -> 7

# Blog: https://pjcs-pwc.blogspot.com/2022/05/d00dle5-we-are-asked-for-list-of-2-8.html

my ($dictionary, $word, $count, $word2, $words); 

# fetch dictionary
$dictionary = `curl -s -L https://github.com/manwar/perlweeklychallenge-club/raw/master/data/dictionary.txt`;

# as stated above
say qq[\nAs stated in challenge:];
$count = 0;
WORD: while ($dictionary =~ m|(.*)?\n|g) {
	$word = $1;
	
	# eliminate too short, too long or containing illegal lettes
	next if (length($word) < 2 or length($word) > 8) or $word =~ m|[^abcdefolist]|i;
	
	# make 'special' substitutions
	$word =~ y|oistlOISTL|0157101571|;
	
	# output
	print sprintf('%9s', uc($word));
	print qq[\n] unless ++$count %10;
}
print qq[\n] if ++$count %10;
say qq[$count words];

#----------------------------------------------------------------------------------

# not allowing l -> 1
say qq[\nOmitting l -> 1:];
$count = 0;
WORD: while ($dictionary =~ m|(.*)?\n|g) {
	$word = $1;
	next if (length($word) < 2 or length($word) > 8) or $word =~ m|[^abcdefoist]|i;
	$word =~ y|oistOIST|01570157|;
	print sprintf('%9s', uc($word));
	print qq[\n] unless ++$count %10;
}
print qq[\n] if ++$count %10;
say qq[$count words];

#----------------------------------------------------------------------------------

# limiting 'specials' to 3 (optional extra 1)
say qq[\nLimiting 'specials' to 3:];
$count = 0;
WORD: while ($dictionary =~ m|(.*)?\n|g) {
	$word = $1;
	next if (length($word) < 2 or length($word) > 8) or $word =~ m|[^abcdefoist]|i;
	
	# check number of specials
	$word2 = $word;
	$word2 =~ s|[^oist]||g;
	next if length($word2) > 3;
	
	$word =~ y|oistOIST|01570157|;
	print sprintf('%9s', uc($word));
	print qq[\n] unless ++$count %10;

}
print qq[\n] if ++$count %10;
say qq[$count words];
