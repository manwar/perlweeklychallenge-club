#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-16
# PWC 165 task 1

use v5.28;
use strict;
use warnings;
use utf8;
use SVG;

# Your task is to accept a series of points and lines in the following format, 
# one per line, in arbitrary order:

# Point: x,y
# Line: x1,y1,x2,y2

# ... and create a SVG graohic showing them.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/dots-lines-and-whatever-fits-best.html

my ($grp, $grp1, $grp2, $i, $object, $size, $svg, $x1, $x2, $y1, $y2, @objects);

# data
@objects = ([20, 20], [20, 20, 20, 50], [20, 50], [20, 50, 50, 75], [50, 75],
		[80, 50], [20, 50, 80, 50], [50, 75, 80, 50], [80, 20], [80, 50, 80, 20],
		[80, 20, 20, 20]);

# create bounding box
$size = 100;
$svg = SVG->new(width => $size, height => $size);

# define groups
$grp1 = $svg->group(id => 'line_group',
    style => {stroke => 'blue', fill => 'blue'});
$grp2 = $svg->group(id => 'dot_group',
    style => {stroke => 'orange', fill => 'orange'});

# process lines and points - nb - SVG space has y axis zero at top
# so we have to use (height - y) to show in a right-handed space
for $object (@objects) {
	$i ++;
	
	# a point
	if (scalar(@$object) == 2) {
		($x1, $y1) = @$object;
		$grp2->circle(id => "dot$i", cx => $x1, cy => $size - $y1, r => 2);
		
	# a line
	} elsif (scalar(@$object) == 4) {
		($x1, $y1, $x2, $y2) = @$object;
		$grp1->line(id => "line$i", 
			x1 => $x1, y1 => $size - $y1, 
			x2 => $x2, y2 => $size - $y2);		
	}
}

# export the svg code
open OUT, '>pjcs_week165_task1.svg' or die $!;
print OUT $svg->xmlify;
close OUT;
