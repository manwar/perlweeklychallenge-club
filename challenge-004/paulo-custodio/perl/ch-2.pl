#!/usr/bin/perl

# Challenge 004
# 
# Challenge #2
# You are given a file containing a list of words (case insensitive 1 word per line) and a list of letters. Print each word from the file that can be made using only letters from the list. You can use each letter only once (though there can be duplicates and you can use each of them once), you don’t have to use all the letters. (Disclaimer: The challenge was proposed by Scimon Proctor)

use strict;
use warnings;
use 5.030;

@ARGV==2 or die "Usage: ch-2.pl dict letters\n";
my($dict_file, $letters) = @ARGV;

$letters = lc($letters);

open(my $fh, "<", $dict_file) or die "open $dict_file: $!\n";
while (<$fh>) {
	chomp;
	say $_ if matches($_, $letters);
}


sub matches {
	my($word, $letters) = @_;
	for my $c (split //, $letters) {
		$word =~ s/$c//;
		return 1 if $word eq '';
	}
	return 0;
}
