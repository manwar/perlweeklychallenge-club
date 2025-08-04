#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-04
use utf8;     # Week 333 - task 1 - Straight line
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

straight_line([2, 1], [2, 3], [2, 5]);
straight_line([1, 4], [3, 4], [10, 4]);
straight_line([0, 0], [1, 1], [2, 3]);
straight_line([1, 1], [1, 1], [1, 1]);
straight_line([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]);
straight_line([0, 0], [1, 1], [99999999, 100000000]);
straight_line([8, -5], [3, -2], [-2, 1]);
straight_line([8, -5], [3, -2], [-2, 1], [-7, 4], [-12, 7]);
straight_line([0, 0], [1, 0], [2, 1], [3, 2]);

sub straight_line {
	
	my (@p, $i, $j, @x, @y, $c, $d, $m, $yy, $same, $vertical, $input, $output);
	
	# initialise
	@p = @_;
	$i = 0;
	$vertical = $same = 1;

	# loop over points
	for $i (0 .. $#p) {
		($x[$i], $y[$i]) = @{$p[$i]};
		$input .= '[' . sprintf('%d', $x[$i]) . ', ' . sprintf('%d', $y[$i]) . '], ';
		
		# check for points being identical or all the same x
		if ($i > 0) {
			if ($x[$i] != $x[0] or $y[$i] != $y[0]) {
				$same = 0;
				$d = $i;  # a point with diffferent x from x[0]
			}
			$vertical = 0 if $x[$i] != $x[0];
		}
	}
	$output = qq[true: any straight line through ($x[0], $y[0])] if $same;
	$output = qq[true: x = $x[0]] if ($vertical and not $same);
	
	# otherwise calculate gradient and offset (using points 0 and d)
	unless ($output) {
		$m = 0;
		$m = ($y[$d] - $y[0]) / ($x[$d] - $x[0]);
		$c = $y[0] - $m * $x[0];
		
		# check that all points fall on y = mx + c
		for $i (0 .. $#p) {
			$yy = $m * $x[$i] + $c;
		if (abs($yy - $y[$i]) > 1e-15) {
				$output = qq[false: ($x[$i], $y[$i]) is not collinear with points 0 and $d];
				last;
			}
		}
		
		# yes they do!
		$output = qq[true: y = ] . ($m != 0 ? ($m == -1 ? '-x' : ($m != 1 ? "${m}x " : 'x ')) : '') . 
			($m != 0 ? ($c == 0 ? '' : ($c > 0 ? "+ $c" : '- ' . -$c)) : $c) unless $output;
	}
	
	say qq{\nInput:  \$list = (} . substr($input, 0, -2) . ')';
	say qq[Output: $output];
}
