#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-02-12
use utf8;     # Week 256 - task 2 - Merge strings
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

merge_strings('abcdefg', 'zyxwvut');
merge_strings('abcde', 'DEFGHIJK');
merge_strings('', '');
merge_strings('Pr ekyCalne', 'elWel hleg');

sub merge_strings {
	
	my (@a, @b, $c, $j, $c_last);
	
	# split the strings into array
	@a = split('', $_[0]);
	@b = split('', $_[1]);
	$c = '';
	$c_last = scalar @a + scalar @b - 1;
	
	# form the result by zipping them together
	for $j (0 .. 9999) {
		$c .= $a[$j] if $j < scalar @a;
		$c .= $b[$j] if $j < scalar @b;
		last if $j == $c_last;
	}
	
	# and show the result
	say qq[\nInput:  \$str1 = '$_[0]', \$str2 = '$_[1]'];
	say qq[Output: '$c'];	
}
