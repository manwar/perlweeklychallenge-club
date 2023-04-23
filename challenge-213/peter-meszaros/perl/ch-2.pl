#!/usr/bin/perl
# Example 1:
# 
# Input: @routes = ([1,2,6], [5,6,7])
#        $source = 1
#        $destination = 7
# 
# Output: (1,2,6,7)
# 
# Source (1) is part of route [1,2,6] so the journey looks like 1 -> 2 -> 6
# then jump to route [5,6,7] and takes the route 6 -> 7.
# So the final route is (1,2,6,7)
# 
# Example 2:
# 
# Input: @routes = ([1,2,3], [4,5,6])
#        $source = 2
#        $destination = 5
# 
# Output: -1
# 
# Example 3:
# 
# Input: @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8])
#        $source = 1
#        $destination = 7
# Output: (1,2,3,8,7)
# 
# Source (1) is part of route [1,2,3] so the journey looks like 1 -> 2 -> 3
# then jump to route [3,8,9] and takes the route 3 -> 8
# then jump to route [7,8] and takes the route 8 -> 7
# So the final route is (1,2,3,8,7)

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[[1,2,6], [5,6,7]],
	[[1,2,3], [4,5,6]],
	[[1,2,3], [4,5,6], [3,8,9], [7,8]],
];

# Based on https://www.geeksforgeeks.org/find-paths-given-source-destination/
package Graph {
	use Data::Dumper;

    sub new
    {
        my ($class, $size) = @_;

        my $self = bless {}, $class;

        $self->{size} = $size;
        $self->{vert} = {};

        return $self;
    }

	sub addEdge
    {
        my ($self, $u, $v) = @_;

		push $self->{vert}->{$u}->@*, $v;
    }

	sub _printAllPathsUtil
    {
	    my ($self, $u, $d, $visited, $path) = @_;
		$visited->[$u] = 1;
		push @$path, $u;

		if ($u == $d) {
			push $self->{path}->@*, [$path->@*];
			#print Dumper($self->{path}), '[', join(', ', @$path), "]\n";
		} else {
			for my $i ($self->{vert}->{$u}->@*) {
				if (not defined $visited->[$i] or $visited->[$i] == 0) {
					$self->_printAllPathsUtil($i, $d, $visited, $path);
                }
            }
        }
					
		pop(@$path);
		$visited->[$u] = 0;
    }

	sub printAllPaths
    {

	    my ($self, $s, $d) = @_;

		my $visited = [];
		my $path = [];

		$self->{path} = [];
		$self->_printAllPathsUtil($s, $d, $visited, $path);
		return ($self->{path}->@* == 0) ? -1 : $self->{path}; 
    }
};

sub pathstoedges
{
    my $paths = shift;

    my $edges = [];
    for my $path (@$paths) {
		my $p = shift @$path;
		for my $v (@$path) {
			push @$edges, [$p, $v], [$v, $p];
			$p = $v;
		}
    }
	return $edges;
}

sub testcase
{
	my ($case, $fm, $to) = @_;
	my $edges = pathstoedges($case);
	my $g = Graph->new(scalar @$edges);
	$g->addEdge(@$_) for (@$edges);
	return $g->printAllPaths($fm, $to);
}

is_deeply(testcase($cases->[0], 1, 7), [[1,2,6,7]],   '[[1,2,6], [5,6,7]]');
is_deeply(testcase($cases->[1], 2, 5), -1,            '[[1,2,3], [4,5,6]]');
is_deeply(testcase($cases->[2], 1, 7), [[1,2,3,8,7]], '[[1,2,3], [4,5,6], [3,8,9], [7,8]]');
done_testing();

exit 0;
