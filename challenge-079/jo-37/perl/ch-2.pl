#!/usr/bin/perl

use 5.014;
use Test2::V0;
no warnings 'experimental::smartmatch';
use List::Util qw(uniqnum);

# Count the trapped rain volume.
sub trapped_rain_water {
	my @hist = @_;

	my $vol = 0;
	my $prev_y;

	# Iterate over the histogram at all distinct heights, increasingly.
	for my $y (uniqnum sort {$a <=> $b} @hist) {
		# At the floor.
		unless (defined $prev_y) {
			$prev_y = $y;
			next;
		}
		# Get step size.
		my $stepsize = $y - $prev_y;
		$prev_y = $y;

		my $length = 0;
		my $leftwall = '';

		# Iterate at the current height.
		for my $x (0 .. $#hist) {
			# Build a string representing the current position in the
			# histogram.  Depicts the walls.
			for ($leftwall . '_' . ($hist[$x] >= $y)) {

				# At first wall.
				when ('_1') {
					$leftwall = 1;
				};

				# After left wall: increment the length of the temporary
				# rectangle.
				when ('1_') {
					$length++;
				};

				# At right wall: The temporary volume after the left
				# wall (if any) is now trapped by a right wall.  The
				# right wall becomes the new left wall.
				when ('1_1') {
					$vol += $length * $stepsize;
					$length = 0;
				};
			}
		}
	}

	$vol;
}

is trapped_rain_water(2, 1, 4, 1, 2, 5), 6, 'first example';
is trapped_rain_water(3, 1, 3, 1, 1, 5), 6, 'second example';
# Other tests:
is trapped_rain_water(7, 1, 1, 1, 7), 18, 'bucket';
is trapped_rain_water(3, 2, 1, 2, 3), 4, 'gorge';
is trapped_rain_water(1, 2, 3, 2, 1), 0, 'hill';
is trapped_rain_water(1, 2, 3, 4, 5), 0, 'uphill';
is trapped_rain_water(5, 4, 3, 2, 1), 0, 'downhill';
is trapped_rain_water(1, 1, 1, 1, 1), 0, 'plain';

done_testing;
