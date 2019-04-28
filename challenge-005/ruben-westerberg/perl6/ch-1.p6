#!/usr/bin/env perl6
#
use lib $?FILE.IO.dirname;
use anagram;
my $wordsFile=  $?FILE.IO.dirname ~ "/../words_alpha.txt";

my @word-list=$wordsFile.IO.lines;
my $input= @*ARGS[0];
my @letters=$input.trim.lc.split("")[1..*-2];
say "Anagrams: ",findAnangrams(@letters,@word-list).join: ' ';

