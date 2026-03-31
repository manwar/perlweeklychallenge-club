#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-23
use utf8;     # Week 366 - task 1 - Count prefixes
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

count_prefixes(['a', 'ap', 'app', 'apple', 'banana'], 'apple');
count_prefixes(['cat', 'dog', 'fish'], 'bird');
count_prefixes(['hello', 'he', 'hell', 'heaven', 'he'], 'hello');
count_prefixes(['', 'code', 'coding', 'cod'], 'coding');
count_prefixes(['p', 'pr', 'pro', 'prog', 'progr', 'progra', 'program'], 'program');

sub count_prefixes {
	
	my (@words, $string);
	
	# initialise
	@words = @{$_[0]};
	$string = $_[1];
	
	# report
	say qq[\nInput:  \$words = ('] . join(q[', '], @words) . 
		qq['), \$string = '$string'];
	say qq[Output: ] . grep { $string =~ m|^$_| } @words;
}
