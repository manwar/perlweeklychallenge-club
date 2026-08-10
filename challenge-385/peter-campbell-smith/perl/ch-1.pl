#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/385/1

use v5.26;    # The Weekly Challenge - 2026-08-03
use utf8;     # Week 385 - task 1 - Uncommon words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

uncommon_words('the cat sat on the mat', 'the dog sat on the rug');
uncommon_words('house', 'house');
uncommon_words('apple banana apple', 'banana orange');
uncommon_words('blue blue red', 'red green green yellow');

sub uncommon_words {
	
	my ($words, %freq, $uncommon);
	
	# initialise
	$words = lc(qq[$_[0] $_[1]]);
	$uncommon = '';
	
	# count frequencies
	$freq{$1} ++ while $words =~ m|([a-z]+)|g;
	
	# check for frequency 1
	$uncommon .= ($freq{$_} == 1 ? qq['$_', ] : '') for keys %freq;
	$uncommon = 'none  ' unless $uncommon;
	
	say qq[\nInput:  \$sentence1 = '$_[0]',];
    say qq[        \$sentence2 = '$_[1]'];
	say qq[Output: ] . substr($uncommon, 0, -2);
}
