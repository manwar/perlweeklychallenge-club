#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-07
use utf8;     # Week 290 - task 1 - Double exist
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

double_exist(6, 2, 3, 3);
double_exist(3, 1, 4, 13);
double_exist(2, 1, 4, 2);
double_exist(0, 0, 14, 7, -4, -8);

# bigger example
my @ints;
push @ints, int(rand(100)) for (0 .. 19);
double_exist(@ints);

sub double_exist {
	
	my (@ints, %exists, $explain, $j);
	
	# initialise
	@ints = @_;
	$exists{$_} = 1 for @ints;
	
	# find compliant pairs
	for $j (@ints) {
		$explain .= qq[$j and ] . ($j * 2) . ', ' if ($j != 0 and $exists{2 * $j});
	}
	
	# show results
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: ] . ($explain ? (qq[true - ] . substr($explain, 0, -2)) : 'false');
}
