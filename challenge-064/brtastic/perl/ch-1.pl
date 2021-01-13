use v5.24;
use warnings;
use List::Util qw(reduce);

sub find_path
{
	my ($matrix) = @_;

	my @pathfinder = reverse map {
		[reverse map { [$_, [$_]] } $_->@*]
	} $matrix->@*;

	foreach my $path_x (keys @pathfinder) {
		foreach my $path_y (keys $pathfinder[$path_x]->@*) {
			my @alternatives;

			push @alternatives, $pathfinder[$path_x][$path_y - 1]
				if $path_y - 1 >= 0;
			push @alternatives, $pathfinder[$path_x - 1][$path_y]
				if $path_x - 1 >= 0;

			my $found = reduce { $a->[0] < $b->[0] ? $a : $b } @alternatives;
			if (defined $found) {
				$pathfinder[$path_x][$path_y][0] += $found->[0];
				push $pathfinder[$path_x][$path_y][1]->@*, $found->[1]->@*;
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
		], [21, [1, 2, 3, 6, 9]]
	],
	[
		[
			[qw( 1  10 10 )],
			[qw( 1  1  1  )],
			[qw( 10 10 1  )],
		], [5, [1, 1, 1, 1, 1]]
	],
	[
		[
			[qw( 1  10 10 )],
			[qw( 1  10 1  )],
			[qw( 10 10 1  )],
		], [14, [1, 1, 10, 1, 1]]
	],
	[
		[
			[qw( 1  10 10 1 )],
			[qw( 1  3  1  2 )],
			[qw( 10 10 1  5 )],
		], [12, [qw(1 1 3 1 1 5)]]
	]
);

for (@data) {
	my ($matrix, $output) = @$_;
	is_deeply find_path($matrix), $output, "path ok";
}

done_testing;
