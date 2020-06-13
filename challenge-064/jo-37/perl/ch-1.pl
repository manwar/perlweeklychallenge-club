#!/usr/bin/perl

# Use Dijkstra's algorithm to find a minimum weighted path
# through a matrix.
# The algorithm is provided by the "Graph" package.
# To make use of this implementation, the given matrix has to
# be transformed into a directed, weighted graph with the 
# matrix elements as vertices and the valid moves as edges.
# Each edge is assigned a weight that is the move's target matrix
# element.
# Assigning weights to the vertices is not necessary but it
# simplifies the calculation of minimum path's weight.

use Test2::V0;

use Graph;
use List::Util qw(reduce);

# Set to true to display intermediate variables
my $verbose;

# Find minimum path from top left to bottom right in given matrix.
sub minpath {
	my $matrix = shift;
	my $graph = graph($matrix);

	# Get minimum weighted path using Dijkstra's algorithm
	# from start to end vertex.
	my @path = $graph->SP_Dijkstra(vertex(0,0),
		vertex($#$matrix, $#{$matrix->[-1]}));

	print
		join(' -> ', map "$_:" . $graph->get_vertex_weight($_), @path),
		"\n" if $verbose;

	# Sum vertex weights in path.
	reduce {$a + $graph->get_vertex_weight($b)} 0, @path;
}

# Create a directed weighted graph, allowing only
# right or down moves in given matrix.
sub graph {
	my $matrix = shift;
	my $out_edges = edges($matrix);
	my $graph = Graph->new;

	for my $row (0 .. $#$matrix) {
		for my $col (0 .. $#{$matrix->[$row]}) {
			next unless defined $matrix->[$row][$col];
			$graph->add_weighted_edges(&$out_edges($row, $col));
			$graph->set_vertex_weight(vertex($row, $col),
				$matrix->[$row][$col]);
		}
		print "[",
			join(', ', map {defined $_ ? sprintf('%2d', $_) : '  '}
				@{$matrix->[$row]}),
			"]\n" if $verbose;
	}

	$graph;
}

# Generate sub that returns outgoing weighted edges from given vertex
# for this matrix.
sub edges {
	my $matrix = shift;

	sub {
		my ($row, $col) = @_;
		my $vertex = vertex($row, $col);

		# Create argument list for "add_weighted_edges" method.
		# Add edge only if right/down neighbor vertex exists.
		((defined $matrix->[$row][$col + 1] ?
			($vertex, vertex($row, $col + 1),
				$matrix->[$row][$col + 1]) : ()),
		(defined $matrix->[$row + 1] && defined $matrix->[$row + 1][$col] ?
			($vertex, vertex($row + 1, $col),
				$matrix->[$row + 1][$col]) : ()));
	}
}

# Create vertex name.
sub vertex {
	local $" = ',';
	"(@_)";
}

# For testing only:
# Generate matrix from sub
sub narray {
	my $size = shift;
	my $val = pop;
	my $na;
	for my $i (0 .. $size - 1) {
		$na->[$i] = @_ ?  narray(@_, sub {&$val($i, @_)}) : &$val($i);
	}
	$na;
}

# main
$verbose = 1;

# example from challenge
my $example = narray(3, 3, sub {3 * $_[0] + $_[1] + 1});
is minpath($example), 21, 'example from challenge';
print "\n";

# walk around a hill
my $hill = narray(5, 5, sub {$_[0] * (4 - $_[0]) + $_[1] * (4 - $_[1])});
is minpath($hill), 20, 'around the hill';
print "\n";

# walk though a valley
my $valley = narray(5, 5, sub {abs($_[0] - $_[1])}
);
is minpath($valley), 4, 'through the valley';
print "\n";

# walk around holes
my $hole = narray(5, 5, sub {
		1 - ($_[1] == 2 ||
			($_[0] == 0 && $_[1] < 2) ||
			($_[0] == 4 && $_[1] > 2))
		});
undef $hole->[2][2];
is minpath($hole), 3, 'avoid holes';

done_testing;

#srand;
# random matrix
my $rand = narray(3 + int(rand(4)), 3 + int(rand(4)), sub {int(rand(6))});
print "\nToday's random matrix\n";
print "minimum sum: ", minpath($rand), "\n";
