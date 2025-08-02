#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-07-22
use utf8;     # Week 279 - task 1 - Sort letters
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

sort_letters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]);
sort_letters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]);
sort_letters(['a', 'C', 'e', 'e', 'g', 'h', 'l', 'l', 'n'], [3, 1, 6, 9, 8, 2, 4, 5, 7]);

sub sort_letters {
	
	my (@letters, @weights, @sorted);
	
	@letters = @{$_[0]};
	@weights = @{$_[1]};

	# rearrange the letters
	$sorted[$weights[$_] - 1] = $letters[$_] for 0 .. @letters - 1;

	printf(qq[\nInput:  \@letters = ('%s'), \@weights = (%s)\n], join(qq[', '], @letters), join(', ', @weights));
	printf(qq[Output: %s\n], join('', @sorted));
}
