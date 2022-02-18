#!/usr/bin/perl

# Peter Campbell Smith - 2022-02-17
# PWC 152 task 2

use v5.28;
use strict;
use utf8;

# You are given coordinates bottom-left and top-right corner of two rectangles in a 2D plane.
# Write a script to find the total area covered by the two rectangles.

# The required area is the area of rectangle 1 plus that of rectangle 2 minus any shared area.

my ($example, $area, $horiz_overlap, $vert_overlap, %rect);

for $example (1 .. 4) {
	
	# input
	if ($example == 1) {
		#         rect    bottom   left     top     right
		%rect = ( one => {b => -1, l =>  0, t => 2, r => 2},
				  two => {b =>  0, l => -1, t => 4, r => 4} );
				  
	} elsif ($example == 2) {
		%rect = ( one => {b => -3, l => -1, t => 1, r => 3},
				  two => {b => -1, l => -3, t => 2, r => 2} );

	} elsif ($example == 3) {   # rect2 wholly within rect1
		%rect = ( one => {b => -2, l => -2, t => 2, r => 2},
				  two => {b => -1, l => -1, t => 1, r => 1} );
				  
	} elsif ($example == 4) {   # no overlap
		%rect = ( one => {b => 0, l => 0, t => 2, r => 2},
				  two => {b => 2, l => 2, t => 4, r => 4} );
	}
	
	say qq[\nExample $example\nInput:  Rectangle 1 => ($rect{one}{b}, $rect{one}{l}), ($rect{one}{t}, $rect{one}{r})
	Rectangle 2 => ($rect{two}{b}, $rect{two}{l}), ($rect{two}{t}, $rect{two}{r})];
			 
	# Assume no overlap for now
	$area = area('one') + area('two');
				  
	# The rectangles may overlap if the bottom of rect1 is below the top of rect2
	# and the top of rect1 is above the bottom of rect2
	$vert_overlap = $rect{one}{b} < $rect{two}{t} && $rect{one}{t} > $rect{two}{b};

	# They may also overlap if the right of rect1 is to the right of the left of rect2
	# and the left of rect1 is to the left of the right side of rect2
	$horiz_overlap = $rect{one}{r} > $rect{two}{l} && $rect{one}{l} < $rect{two}{r};

	# They do overlap if both of these conditions are true
	if ($vert_overlap && $horiz_overlap) {
		
		# ... and the overlap area is bounded by the greater of the bottoms,
		# the lesser of the tops, the leftmost of the rights and the rightmost 
		# of the lefts		
		$rect{overlap}{b} = $rect{one}{b} > $rect{two}{b} ? $rect{one}{b} : $rect{two}{b};
		$rect{overlap}{t} = $rect{one}{t} > $rect{two}{t} ? $rect{two}{t} : $rect{one}{t};
		$rect{overlap}{l} = $rect{one}{l} > $rect{two}{l} ? $rect{one}{l} : $rect{two}{l};
		$rect{overlap}{r} = $rect{one}{r} > $rect{two}{r} ? $rect{two}{r} : $rect{one}{r};
		
		$area -= area('overlap');
	} else {
		say qq[   No overlap];
	}
	
	say qq[Output: $area];
}

sub area {
	
	my $this = shift;
	my $area = ($rect{$this}{t} - $rect{$this}{b}) * ($rect{$this}{r} - $rect{$this}{l});
	say qq[   Area of $this is $area];
	return $area;
}

