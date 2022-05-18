#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-16
# PWC 165 task 2

use v5.28;
use strict;
use warnings;
use utf8;
use SVG;

# Calculate the least-squares best linear fit of the supplied set of points
# and show the points and line in an SVG graphic.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/dots-lines-and-whatever-fits-best.html

# Given n points where y[i] = a + b * x[i] + e[i] we are seeeking the values 
# of a and b which minimise sum(e[i]^2). These values are:

#      n * sum(x[i] * y[i]) - sum(x[i]) * sum(y[i])
# b =  --------------------------------------------
#            (sum(x[i]^2) - sum(x[i])^2) / n
#
# a = (sum(y[i] - b * sum(x[i]) / n

my (@points, @points1, $n, $i, $x, $y, $sum_x, $sum_xy, $sum_x2, $sum_y, $a, $b,
	$svg, $min_x, $max_x, $min_y, $max_y, $grp, $padding, $width, $height,
	$grp2);

# given data
@points = (333, 129,  39, 189, 140, 156, 292, 134, 393,  52, 160, 166, 362, 122,  13, 193, 
	       341, 104, 320, 113, 109, 177, 203, 152, 343, 100, 225, 110,  23, 186, 282, 102, 
	       284,  98, 205, 133, 297, 114, 292, 126, 339, 112, 327,  79, 253, 136,  61, 169, 
	       128, 176, 346,  72, 316, 103, 124, 162,  65, 181, 159, 137, 212, 116, 337,  86, 
	       215, 136, 153, 137, 390, 104, 100, 180,  76, 188,  77, 181,  69, 195,  92, 186, 
	       275,  96, 250, 147,  34, 174, 213, 134, 186, 129, 189, 154, 361,  82, 363,  89);
	   
# calculate a and b
@points1 = @points;
$n = scalar(@points1) / 2;
$min_x = $min_y = 1000;
$max_x = $max_y = -1000;
for $i (1 .. $n) {
	$x = shift @points1;
	$y = shift @points1;
	$sum_x += $x;
	$sum_y += $y;
	$sum_xy += $x * $y;
	$sum_x2 += $x * $x;
	
	$min_x = $x if $x < $min_x;
	$max_x = $x if $x > $max_x;
	$min_y = $y if $y < $min_y;
	$max_y = $y if $y > $max_y;
}

$b = ($n * $sum_xy - $sum_x * $sum_y) / ($n * $sum_x2 - $sum_x * $sum_x);
$a = ($sum_y - $b * $sum_x) / $n;

# calculate size of box
$padding = 10;
$width = $max_x - $min_x + 2 * $padding;
$height = $max_y - $min_y + 2 * $padding;

# create box
$svg = SVG->new(width => $width, height => $height);

# draw least squares line - nb: SVG's y axis increases in value downwards so invert it
$grp = $svg->group(id => 'line_group',
    style => {stroke => 'blue', fill => 'blue'});
$grp->line(id => 'line', 
	x1 => $padding,                     y1 => $height - ($padding + $a + $b * $min_x) + $min_y, 
	x2 => ($max_x - $min_x + $padding), y2 => $height - ($padding + $a + $b * $max_x) + $min_y);

# draw the dots	
$grp2 = $svg->group(id => 'dots_group',
    style => {stroke => 'orange', fill => 'orange'});
@points1 = @points;
for $i (1 .. $n) {
	$x = shift @points1;
	$y = shift @points1;
	$grp2->circle(id => "dot$i", cx => ($x - $min_x + $padding), cy => ($height - ($padding + $y) + $min_y), r => 2);
}

# export the svg code
open OUT, '>pjcs_week165_task2.svg' or die $!;
print OUT $svg->xmlify;
close OUT;
say qq[The least squares line is y = $a + $b x];
		