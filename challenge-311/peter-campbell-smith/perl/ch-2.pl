#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-03-03
use utf8;     # Week 311 - task 2 - Group digit sum
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

group_digit_sum('111122333', 3);
group_digit_sum('1222312', 2);
group_digit_sum('100012121001', 4);
group_digit_sum('314159265358', 5);

sub group_digit_sum {
	
	my ($str, $int, $new_str, $group, $sum);
	
	# intialise
	($str, $int) = @_;
	$int = 2 if $int < 2;

	# loop until string no longer than $int
	while (length($str) > $int) {		
		$new_str = '';
		
		# loop across groups of digits
		while ($str =~ m|(\d{1,$int})|g) {
			$group = $1;
			$sum = 0;
			$sum += $_ for split('', $group);
			$new_str .= $sum;
		}
		$str = $new_str;
	}

	say qq[\nInput:  \$str = '$_[0]', \$int = $int];
	say qq[Output: '$str'];
}
