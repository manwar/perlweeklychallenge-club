#!/usr/bin/perl
use strict;
use warnings;

sub shortest_route {
    my ($routes, $source, $destination) = @_;
    my %graph;

    for my $route (@$routes) {
        for my $i (0 .. @$route - 2) {
            push @{$graph{$route->[$i]}}, $route->[$i + 1];
            push @{$graph{$route->[$i + 1]}}, $route->[$i];
        }
    }

    my @queue = ([$source]);
    my %visited = ($source => 1);

    while (@queue) {
        my $path = shift @queue;
        my $node = $path->[-1];

        return @$path if $node == $destination;

        for my $neighbor (@{$graph{$node}}) {
            unless ($visited{$neighbor}) {
                $visited{$neighbor} = 1;
                push @queue, [@$path, $neighbor];
            }
        }
    }
    return -1;
}

my @routes = ([1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]);
my $source = 1;
my $destination = 7;

my @result = shortest_route(\@routes, $source, $destination);
print "Output: ";
if (@result > 0) {
    print "(", join(",", @result), ")\n";
} else {
    print "-1\n";
}

