#!/usr/bin/env perl6
#
use lib './';
use anagram;
my $wordsFile= @*ARGS[0] // "words_alpha.txt";

my @word-list=$wordsFile.IO.lines;
while my $input=prompt "Give me a word: " {
	my @letters=$input.trim.lc.split("")[1..*-2];
	say "Anagrams: ",findAnangrams(@letters,@word-list);
}

