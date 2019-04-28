#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
my $wordsFile = $ARGV[0] // $FindBin::Bin.'/../words_alpha.txt';
open my $wfh ,"<", $wordsFile;
my @words;
my %bag;
my $maxLetters;
my $maxCount=-1;
while (<$wfh>) {
	chomp;
	my $key= join '', sort split '';
	$bag{$key}++;
	if ( $bag{$key} > $maxCount) {
		$maxLetters = $key;
		$maxCount= $bag{$key};
	}
}

close $wfh;
print "$maxLetters has $maxCount anagrams\n";


