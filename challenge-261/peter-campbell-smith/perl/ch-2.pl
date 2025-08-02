#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-18
use utf8;     # Week 261 - task 2 - Multiply by 2
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

multiply_by_2([5, 3, 6, 1, 12], 3);
multiply_by_2([1, 2, 4, 3], 1);
multiply_by_2([5, 6, 7], 2);
multiply_by_2([64, 256, 4, 64, 128, 2, 16, 32, 8], 2);

sub multiply_by_2 {
	
	my (@ints, $start, $string);
	
	# initialise
	@ints = @{$_[0]};
	$start = $_[1];
	
	# join @ints as string
	$string = ',' . join(',', @ints) . ',';
	
	# search string as per task
	$start *= 2 while ($string =~ m|,$start,|);
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) .
		qq[}, \$start = $_[1]];
	say qq[Output: $start];
}
