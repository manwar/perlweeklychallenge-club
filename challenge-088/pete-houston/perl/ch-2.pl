#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 8802.pl
#
#        USAGE: ./8802.pl [ filename ] 
#
#  DESCRIPTION: Spiralise matrix
#
#        NOTES: Reads from STDIN if no filename provided
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 23/11/20
#===============================================================================

use strict;
use warnings;

my $matrix = get_data ($ARGV[0]);

my ($rmin, $cmin, $rmax, $cmax) = (0, 0, $#$matrix, $#{$matrix->[0]});
my @turns = ([0, 1], [1, 0], [0, -1], [-1, 0]);
my @out;

# Start at top left, moving right
my ($r, $c) = ($rmin, $cmin);
my $move = 0;

while ($rmin <= $rmax && $cmin <= $cmax) {
	push @out, $matrix->[$r][$c];
	my ($rnext, $cnext) = ($r + $turns[$move][0], $c + $turns[$move][1]);
	if ($rnext < $rmin ||
		$rnext > $rmax ||
		$cnext < $cmin ||
		$cnext > $cmax) {
		# Turn right
		if    ($rnext < $rmin) { $cmin++; }
		elsif ($rnext > $rmax) { $cmax--; }
		elsif ($cnext > $cmax) { $rmin++; }
		else                   { $rmax--; }
		$move = ($move + 1) % 4;
		($r, $c) = ($r + $turns[$move][0], $c + $turns[$move][1]);
	} else {
		($r, $c) = ($rnext, $cnext);
	}
}

print "@out\n";

sub get_data {
	my $fh = \*STDIN;
	if (defined $_[0]) {
		open $fh, '<', $_[0] or die "Cannot open $_[0]: $!";
	}

	my @input;
	my $cols = 0;
	while (my $line = <$fh>) {
		my @ints = ($line =~ /(\d+)/g);
		if ($cols > 0) {
			die "Bad no of items at line $. - should be $cols" unless
				$cols == $#ints + 1;
		} elsif ($#ints < 1) {
			die "Not a rectangle";
		} else {
			$cols = $#ints + 1;
		}
		push @input, \@ints;
	}
	return \@input;
}
