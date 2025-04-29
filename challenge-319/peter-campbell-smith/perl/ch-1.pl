#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-28
use utf8;     # Week 319 - task 1 - Word count
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

word_count('unicode', 'xml', 'raku', 'perl');
word_count('carrot', 'pear', 'cauliflower', 'turnip');
word_count('a', 'ee', 'iii', 'oooo', 'uuuuu');

sub word_count {
	
	my (@words, $w, $count, $result);
	
	# count words starting or ending with a vowel
	for $w (@_) {
		next unless ($w =~ m|^[aeiou]i| or $w =~ m|[aeiou]$|i);
		$result .= qq['$w', ];
		$count ++;
	}
	
	say qq[\nInput:  ('] . join(q[', '], @_) . q[')];
	say qq[Output: ] . ($count ? qq[$count - ] . substr($result, 0, -2) : '0');
}
