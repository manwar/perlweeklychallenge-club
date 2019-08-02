#!/usr/bin/env perl6
my $wordsFile=$?FILE.IO.dirname~"/../words_alpha.txt";
my $max=$wordsFile.IO.lines.race(degree=>4, batch=>50000).map({
	.split("")[1..*-2].sort.join;
}).Bag.antipairs.max;
say "$max.value() has $max.key() anagrams";
