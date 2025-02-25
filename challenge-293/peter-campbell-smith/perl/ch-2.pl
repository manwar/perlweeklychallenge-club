#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-28
use utf8;     # Week 293 - task 2 - Boomerang
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

boomerang([1, 1], [2, 3], [3, 2]); # boomerang
boomerang([1, 1], [2, 2], [3, 3]); # straight line
boomerang([1, 1], [1, 2], [1, 3]); # vertical line
boomerang([1, 1], [1, 2], [2, 3]); # vertical with kink
boomerang([-7, -7], [0, 0], [7, 8]); # boomerang
boomerang([4, 3], [-5, 4], [-2, -2]);

# try ones with very small angle
boomerang([0, 0], [1, 1], [1000, 1000.001]);

sub boomerang {
	
	my ($x1, $x2, $x3, $y1, $y2, $y3, $m, $c, $y0);
	
	($x1, $y1) = ($_[0]->[0], $_[0]->[1]);
	($x2, $y2) = ($_[1]->[0], $_[1]->[1]);
	($x3, $y3) = ($_[2]->[0], $_[2]->[1]);
	say qq[\nInput:  ([$x1, $y1], [$x2, $y2], [$x3, $y3])];
	
	# are the points distinct?
	if (($x1 == $x2 && $y1 == $y2) || ($x1 == $x3 && $y1 == $y3) || ($x2 == $x3 && $y2 == $y3)) {
		say qq[Output: false (points are not distinct)];
		return;
	}

	# general case
	if ($x1 != $x2) {
	
		# get equation y = mx + c of the line joining points 1 and 2
		$m = ($y2 - $y1) / ($x2 - $x1);
		$c = $y1 - $m * $x1;
			
		# see if point 3 is on the line
		$y0 = $m * $x3 + $c;
		
		say qq[Output: ] . (abs($y3 - $y0) < 1e-30 ? 'false' : 'true');
		
	# if point 1 to point 2 is a vertical line
	} else {
		say qq[Output: ] . (abs($x2 - $x3) < 1e-30 ? 'false' : 'true');
	}
		

}
