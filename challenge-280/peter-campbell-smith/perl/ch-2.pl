#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-29
use utf8;     # Week 280 - task 2 - Count asterisks
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

count_asterisks('p|*e*rl|w**e|*ekly|');
count_asterisks('perl');
count_asterisks('th|ewe|e**|k|l***ych|alleng|e');
count_asterisks('*****|*****|*****|*****|');

sub count_asterisks {
	
	my ($str);
	
	$str = shift @_;
	printf(qq[\nInput:  \@str = '%s'\n], $str);

	# remove |.*?| from $str
	$str =~ s/\|.*?\|//g;
	
	# remove non * from $str
	$str =~ s|[^\*]||g;
	
	printf(qq[Output: %s\n], length($str));
}
