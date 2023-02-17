#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-14

use v5.28;
use utf8;
use warnings;
use Time::HiRes qw(time);

# You are given a matrix (m x n) and two integers (r) and (c). Write a script to reshape the given matrix in form 
# (r x c) with the original values in the given matrix. If you can’t reshape print 0.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/204/2

my (@linear, $width, $x);

reshape([[1, 2, 3], [4, 5, 6]], 3, 2);
reshape([[1, 2, 3, 4, 5, 6], [11, 12, 13, 14, 15, 16]], 3, 4);
reshape([[1, 2, 3], [4, 5, 6]], 3, 7);
reshape([[1, 12, 123, 1234], [4321, 321, 21, 1]], 4, 2);

sub reshape {
	
	my ($m_old, $r_new, $c_new) = @_;
	my ($c_old, $r_old, $j, $r, $c, $x);

	# get rows and cols in original array
	$r_old = scalar(@$m_old);
	$c_old = scalar(@{$m_old->[0]});
	
	# collapse old matrix into linear array and check width needed to display
	$j = 0;
	$width = 0;
	for $r (0 .. $r_old - 1) {
		for $c (0 .. $c_old - 1) {
			$x = $m_old->[$r]->[$c];
			$width = length($x) if length($x) > $width;
			$linear[$j ++] = $x;
		}
	}
	$width ++;
	
	# show old matrix
	show("\nInput:  ", $r_old, $c_old);	
	
	# check whether transform is possible
	if ($r_old * $c_old != $r_new * $c_new) {
		say qq[\nOutput: 0\n        \$r = $r_new, \$c = $c_new];
		return;
	}
	
	# show new matrix
	show("\nOutput: ", $r_new, $c_new);
}

sub show {
	
	my ($text, $r, $c) = @_;
	my ($j, $row, $col);
	
	# display matrix
	$j = 0;
	for $col (0 .. $r - 1) {
		for $r (0 .. $c - 1) {
			$row .= sprintf("%${width}d ", $linear[$j ++]);
		}
		say qq[${text}[$row]];
		$row = '';
		$text = '        ';
	}
	say qq[        \$r = $r, \$c = $c];
}
	
	

