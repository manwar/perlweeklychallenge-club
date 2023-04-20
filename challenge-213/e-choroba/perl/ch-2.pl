#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Graph::Undirected;

sub shortest_route(%args) {
    my $graph = 'Graph::Undirected'->new;
    for my $route (@{ $args{routes} }) {
        for my $i (0 .. $#$route - 1) {
            $graph->add_edge($route->[$i], $route->[ $i + 1 ]);
        }
    }
    my @route = $graph->SP_Dijkstra(@args{qw{ source destination }});
    return \@route if @route;

    return -1
}

use Test2::V0;
plan 3;

is shortest_route(routes      => [[1, 2, 6], [5, 6, 7]],
                  source      => 1,
                  destination => 7),
    [1, 2, 6, 7],
    'Example 1';

is shortest_route(routes      => [[1, 2, 3], [4, 5, 6]],
                  source      => 2,
                  destination => 5),
    -1,
    'Example 2';

is shortest_route(routes      => [[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]],
                  source      => 1,
                  destination => 7),
    [1, 2, 3, 8, 7],
    'Example 3';
