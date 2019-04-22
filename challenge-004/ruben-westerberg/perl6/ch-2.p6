#!/usr/bin/env perl6
#Read a list of words to process
#Read file of letters
my $lettersFile=@*ARGS[0];
my $wordsFile=@*ARGS[1];
my %letters=$lettersFile.IO.slurp.trim.split("")[1..*-2].Bag.hash;
my %words=$wordsFile.IO.lines.map({$_.trim => .trim.split("")[1..*-2].Bag.hash});
say (%words.map: {
	my @keys= .value.keys;
	my @result= ($_.value{@keys}) Z<= (%letters{@keys});
	.key if so all @result;
});
