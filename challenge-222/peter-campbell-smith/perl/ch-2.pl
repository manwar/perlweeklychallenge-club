#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-06-19
use utf8;     # Week 222 task 2 - Last member
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

last_member(2, 7, 4, 1, 8, 1);
last_member(1);
last_member(1, 1);

# longer example
my ($j, @ints);
for $j (0 .. 9) {
	$ints[$j] = int(rand(49)) + 1;
}
last_member(@ints);

sub last_member {
	
	my (@ints, $diff, $legend);
	
	# initialise
	@ints = @_;
	$legend = '';
	
	# loop until 0 or 1 left
	while (scalar @ints > 1) {
		
		# sort remaining list in decreasing order
		@ints = sort { $b <=> $a } @ints;
		
		# remove two largest, and add difference if they differ
		$legend .= qq[\n  Pick $ints[0] and $ints[1], we remove both ];
		$diff = (shift @ints) - (shift @ints);
		unshift @ints, $diff if $diff;
		
		# and say what we've done
		$legend .= qq[and add new member $diff ] if $diff;
		$legend .= scalar @ints > 0 ? qq[=> (] . join(', ', @ints) . q[)] : q[and are left with none];
	}
	
	# report findings
	say qq[\nInput: \@ints = (] . join(', ', @_) . q[)];
	say qq[Output: ] . (defined $ints[0] ? $ints[0] : '0') . $legend;
}