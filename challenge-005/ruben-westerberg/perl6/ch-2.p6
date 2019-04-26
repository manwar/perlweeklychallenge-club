#!/usr/bin/env perl6
my $wordsFile=$*ARGS[0] // "words_alpha.txt";
say $wordsFile.IO.lines.hyper(degree=>4, batch=>50000).map({
	.split("")[1..*-2].sort.join;
}).Bag.antipairs.max;
