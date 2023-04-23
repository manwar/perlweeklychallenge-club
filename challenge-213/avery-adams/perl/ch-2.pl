#!/usr/bin/perl

use strict;
use v5.24;
use List::Util 'min';

my @routes = ([1, 2, 6], [5, 6, 7]);
my $source = 1;
my $destination = 7;

print_dijkstra(\@routes, $source, $destination);

@routes = ([1, 2, 3], [4, 5, 6]);
$source = 2;
$destination = 5;

print_dijkstra(\@routes, $source, $destination);

@routes = ([1,2,3], [4,5,6], [3,8,9], [7,8]);
$source = 1;
$destination = 7;

print_dijkstra(\@routes, $source, $destination);

sub print_dijkstra {
    my $result = dijkstra(@_);
    if ($result == -1) {
        say -1;
    } else {
        my @route = @{$result};
        for (@route) {
            $_ != $route[$#route] ? print "$_, " : print "$_\n"
        }
    }
}

sub dijkstra {
    my ($routeref, $source, $destination) = @_;
    my @routes = @{$routeref};

    my %adjacency;
    for my $route (@routes) {
        my @nodes = @$route;
        for my $i (0 .. $#nodes - 1) {
            push @{$adjacency{$nodes[$i]}}, $nodes[$i + 1];
            push @{$adjacency{$nodes[$i + 1]}}, $nodes[$i];
        }
    }

    my %distance;
    my %visited;
    my %previous;
    $distance{$source} = 0;

    my %new_visits;
    while (keys %visited != keys %adjacency) {
        my $node = min(grep {!defined $visited{$_}} keys %distance);
        $visited{$node} = 1;

        for my $adjacent (@{$adjacency{$node}}) {
            my $total_distance = $distance{$node} + 1;
            if (!defined $distance{$adjacent} || $total_distance < $distance{$adjacent}) {
                $distance{$adjacent} = $total_distance;
                $previous{$adjacent} = $node;
            }
        }

        if (%visited == %new_visits && !$visited{$destination}) {
            return -1;
        } elsif ($visited{$destination}) {
            last;
        }
        %new_visits = %visited;
    }

    my @route;
    my $node = $destination;
    while ($node != $source) {
        unshift @route, $node;
        $node = $previous{$node};
    }
    unshift @route, $source;

    return \@route;
}