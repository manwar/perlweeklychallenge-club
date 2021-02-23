#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10101.pl
#
#        USAGE: ./10101.pl A [ A ... ]
#
#  DESCRIPTION: Spiralise array
#
#        NOTES: This is essentially the reverse of 8802.pl
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/02/21
#===============================================================================

use strict;
use warnings;

my ($r, $c) = dimensions (scalar @ARGV);
display_spiral (--$r, --$c, @ARGV);

sub dimensions {
	my $n = shift;
	my $r = sqrt ($n);
	# Is it a square?
	return ($r, $r) if $r == int $r;
	$r = int $r;

	while ($r > 1) {
		my $c = $n / $r;
		return ($r, $c) if $c == int $c;
		$r--;
	}
	return ($r, $n);
}

sub display_spiral {
	my ($rmax, $cmax, @x) = @_;
	my $rmin  = 0;
	my $cmin  = 0;
	my @turns = ([0, 1], [-1, 0], [0, -1], [1, 0]);
	my @out;

	# Start at bottom left, moving right
	my ($r, $c) = ($rmax, $cmin);
	my $move = 0;

	while ($rmin <= $rmax && $cmin <= $cmax) {
		$out[$r]->[$c] = shift @x;
		my ($rnext, $cnext) = ($r + $turns[$move][0], $c + $turns[$move][1]);
		if ($rnext < $rmin ||
			$rnext > $rmax ||
			$cnext < $cmin ||
			$cnext > $cmax) {
			# Turn left
			if    ($rnext < $rmin) { $cmax--; }
			elsif ($rnext > $rmax) { $cmin++; }
			elsif ($cnext > $cmax) { $rmax--; }
			else                   { $rmin++; }
			$move = ($move + 1) % 4;
			($r, $c) = ($r + $turns[$move][0], $c + $turns[$move][1]);
		} else {
			($r, $c) = ($rnext, $cnext);
		}
	}

	print "@$_\n" for @out;
}
