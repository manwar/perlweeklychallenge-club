#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12602.pl
#
#        USAGE: ./12602.pl < INFILE
#
#  DESCRIPTION: Output minesweeper grid based on INFILE.
#
# REQUIREMENTS: Input must be on STDIN
#        NOTES: Input file should consist of a rectangular grid with
#               values of "x" or "*" only. Any other characters will be
#               ignored, so use as much/little in-line whitespace as you
#               like. Each line of input must have the same number of
#               valid characters otherwise an exception will be thrown.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 16/08/21
#===============================================================================

use strict;
use warnings;

my @grid;
my $len;

while ($_ = <STDIN>) {
	my @row = /([*x])/g;
	if (defined $len) {
		die "Non-rectangular grid" unless $#row == $len;
	} else {
		$len = $#row;
	}
	push @grid, \@row;
}

for my $r (0..$#grid) {
	for my $c (0..$len) {
		next if $grid[$r][$c] eq 'x'; # Bombs are bombs

		# Count the neighbours
		my $sum = 0;
		for my $y ($r - 1 .. $r + 1) {
			for my $x ($c - 1 .. $c + 1) {
				$sum++ if
					$y >= 0 && $y <= $#grid &&
					$x >= 0 && $x <= $len &&
					($y != $r || $x != $c) &&
					$grid[$y][$x] eq 'x';
			}
		}
		$grid[$r][$c] = $sum;
	}
	print "@{$grid[$r]}\n";
}
