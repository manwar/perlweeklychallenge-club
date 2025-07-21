#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-21
use utf8;     # Week 331 - task 1 - Last word
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

last_word('The Weekly Challenge');
last_word('   Hello   World    ');
last_word('123 4567');
last_word('');
last_word('Danger!');

sub last_word {
	
	$_[0] =~ m|([a-z]+)[^a-z]*$|i;
	
	say qq[\nInput: '$_[0]'];
	say qq[Output: ] . (defined($1) ? length($1) : 0);
}
