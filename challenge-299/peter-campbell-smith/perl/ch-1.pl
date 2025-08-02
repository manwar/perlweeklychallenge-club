#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-12-09
use utf8;     # Week 299 - task 1 - Replace words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

replace_words(['cat', 'bat', 'rat'], 'the cattle were rattled by the battery');
replace_words(['a', 'b', 'c'], 'aab aac and cac bab');
replace_words(['six', 'three', 'four', 'one', 'five', 'two'],
	'oneway twotime threesome fourfold fiver sixty');

sub replace_words {
	
	my (@words, $sentence);
	
	# initialise
	@words = @{$_[0]};
	$sentence = ' ' . $_[1];
	say qq[\nInput:  \@words = ('] . join(q[', '], @words) . qq['), \$sentence = '$_[1]'];
	
	# do it and report
	$sentence =~ s| $_\w+| $_|g for @words;	
	say qq[Output:$sentence];
}
