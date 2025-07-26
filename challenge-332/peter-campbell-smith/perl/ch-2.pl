#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-28
use utf8;     # Week 332 - task 2 - Odd letters
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

odd_letters('weekly');
odd_letters('You are given a string');
odd_letters('a bBb ccCcc dddDddd eeeeEeeee');
odd_letters('supercalifragilisticexpialidocious');
odd_letters('12345 +=-*<>');

sub odd_letters {
	
	my (%counts, $j);
	
	# initialise
	say qq[\nInput:  \$str = '$_[0]'];
	
	# count occurrences of each unique letter
	$counts{$_} ++ for split('', lc($_[0]));
	
	# see if the counts of letters are all odd
	for $j (keys %counts) {
		next if ($counts{$j} & 1 or $j !~ m|[a-z]|);
		say qq[Output: false ('$j' occurs $counts{$j} times)];
		return;
	}
	
	say qq[Output: true];
}
