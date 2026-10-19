#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/396/2

use v5.26;    # The Weekly Challenge - 2026-10-19
use utf8;     # Week 396 - task 2 - Trionic array
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

trionic_array(1, 3, 5, 4, 2, 6, 8);
trionic_array(1, 4, 4, 2, 1, 3, 5);
trionic_array(2, 10, 3, 1, 9);
trionic_array(1, 2, 3, 4, 3, 2, 1);
trionic_array(1, 3, 6, 4, 2, 7, 8, 4);
trionic_array(1);
trionic_array(1, 2);
trionic_array(1, 2, 1);
trionic_array(1, 2, 1, 2);
trionic_array(2, 1);
trionic_array(2, 1, 0, 1, 2, 1);
trionic_array(-5 .. 0, -1 .. 5);

sub trionic_array {
	
	my (@array, $j, $profile);
	
	# initialise
	@array = @_;
	$profile = '';
	say qq[\nInput:  (] . join(', ', @array) . ')';
	
	# loop over heights
	for $j (0 .. $#array - 1) {
		if    ($array[$j + 1] > $array[$j]) { $profile .= 'u' }
	 	elsif ($array[$j + 1] < $array[$j]) { $profile .= 'd' }
		else                                { $profile = ''; last }
	}
	
	# report
	if ($profile =~ m|^((u+)d+)u+$|) {
		say qq[Output: true, \$p = ] . length($2) .  
			qq[, \$q = ] . length($1);
	} else {
		say qq[Output: false]
	}
}
