use v5.24;
use warnings;
use List::Util qw(min);

sub find_path
{
	my ($matrix) = @_;

	my @pathfinder = reverse map { [reverse $_->@*] } $matrix->@*;
	foreach my $path_x (keys @pathfinder) {
		foreach my $path_y (keys $pathfinder[$path_x]->@*) {
			my @alternatives;

			push @alternatives, $pathfinder[$path_x][$path_y - 1]
				if $path_y - 1 >= 0;
			push @alternatives, $pathfinder[$path_x - 1][$path_y]
				if $path_x - 1 >= 0;

			if (@alternatives > 0) {
				$pathfinder[$path_x][$path_y] += min @alternatives;
			}
		}
	}

	return $pathfinder[-1][-1];
}

use Test::More;

my @data = (
	[
		[
			[qw( 1 2 3 )],
			[qw( 4 5 6 )],
			[qw( 7 8 9 )],
		], 21
	],
	[
		[
			[qw( 1  10 10 )],
			[qw( 1  1  1  )],
			[qw( 10 10 1  )],
		], 5
	],
	[
		[
			[qw( 1  10 10 )],
			[qw( 1  10 1  )],
			[qw( 10 10 1  )],
		], 14
	]
);

for (@data) {
	my ($matrix, $output) = @$_;
	is find_path($matrix), $output, "path ok";
}

done_testing;
