#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 7502.pl
#
#        USAGE: ./7502.pl N ...
#
#  DESCRIPTION: Report the area of the biggest rectangle in the historgram.
#
# REQUIREMENTS: List::Util, List::MoreUtils
#        NOTES: Each N must be a natural number.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 24/08/20
#===============================================================================

use strict;
use warnings;
use List::Util 'max';
use List::MoreUtils 'uniq';

histarea (@ARGV);

sub histarea {
	my @in = @_;
	my $size = scalar @in;
	my $area = $size;
	my $axb  = "1 x $size";
	my @steps = sort { $a <=> $b } uniq @in;
	for my $height (@steps) {
		my $contig = 0;
		my $max = 0;
		for my $col (@in) {
			if ($col >= $height) {
				$contig++;
				$max = max $max, $contig;
			} else {
				$contig = 0;
			}
		}
		my $rect = $max * $height;
		if ($rect > $area) {
			$area = max $area, $rect;
			$axb  = "$max x $height";
		}
	}
	print "Largest rectangle is $axb with area $area\n";
	&print_histo;
}

sub print_histo {
	my @y = @_;
	my $yval = max (@y);
	while ($yval) {
		printf "\%6i\%s\n",
			$yval, join '', map { $_ >= $yval ? ' #' : '  ' } @y;
		$yval--;
	}
	print ' ' x 4, ' _' x (1 + @y), "\n       @y\n";
}
