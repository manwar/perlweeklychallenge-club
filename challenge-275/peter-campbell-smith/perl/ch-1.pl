#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-06-24
use utf8;     # Week 275 - task 1 - Broken keys
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

# You are given a sentence !!$sentence!! and list of broken keys !!@keys!!.
# Write a script to find out how many words can be typed fully.

my ($sentence, @keys);

broken_keys('Perl Weekly Challenge', 'l', 'a');
broken_keys('The joys of polyglottism', 'T');
broken_keys('Write a script to find out how many words can be typed fully', 'i', 'o');
broken_keys('All cows eat grass', 'b', 'd', 'f', 'h', 'i');
broken_keys('Vitamins keep you healthy', 'v', 'k', 'u', 'y');

sub broken_keys {
	
	my ($sentence, @keys, $count);
	
	printf(qq[\nInput:  \$sentence = ('%s'), \@keys = ('%s')\n], $_[0], join(q[', '], @_[1 .. @_ - 1]));
	$sentence = lc(shift @_);
	push @keys, lc($_) for @_;
	
	# change any occurrences of keys to '#'
	$sentence =~ s|$_|#|g for @keys;
	
	# count the words which don't contain '#'
	$count += ($_ !~ m|#| ? 1 : 0) for split(/ /, $sentence);
	
	printf(qq[Output: %s\n], defined $count ? $count : 0);
}
