#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-01
use utf8;     # Week 215 task 2 - Number placement
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

number_placement([1, 0, 0, 0, 1], 1);
number_placement([1, 0, 0, 0, 1], 2);
number_placement([0, 0, 1, 0, 0, 0, 1, 0, 0], 3);

sub number_placement {

	my (@numbers, $count, $string, $j, $done);
	
	@numbers = @{$_[0]};
	$count = $_[1];
	
	$string = join('', @numbers);
	for $j (1 .. $count) {
		$done ++ if ($string =~ s|000|010| or 
			$string =~ s|^00|10| or $string =~ s|00$|01|);
	}
	say qq[\nInput:  \@numbers = (] . join(', ', @numbers) .
		qq[), \$count = $count];
	say qq[Output: ] . ($done == $count ? 1 : 0);
	
}