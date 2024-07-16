#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-15
use utf8;     # Week 278 - task 1 - Sort string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

# You are given a shuffle string, $str.
# Write a script to return the sorted string.
# A string is shuffled by appending word position to each word.

sort_string('and2 Raku3 cousins5 Perl1 are4');
sort_string('A1 appending6 by5 each10 is3 position8 shuffled4 string2 to9 word7 word11');
sort_string('a3 challenge11 is2 line5 one4 solution6 Sort9 String10 the8 This1 to7');

sub sort_string {
	
	my ($string, @new);
	$string = shift;
	
	# new[$n - 1] is the $n'th word in the output string
	@new[$2 - 1] = $1 while $string =~ m|([a-z]+)(\d+)|gi;
	
	printf(qq[\nInput:  \@string = '%s'\n], $string);
	printf(qq[Output: '%s'\n], join(' ', @new));
}
