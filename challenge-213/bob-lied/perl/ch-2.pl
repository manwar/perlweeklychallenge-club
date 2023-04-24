#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 213 Task 2 Shortest Route 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of bidirectional routes defining a network of nodes,
# as well as source and destination node numbers.
# Write a script to find the route from source to destination that passes
# through fewest nodes.
# Example 1: Input: @routes = ([1,2,6], [5,6,7]) $source = 1 $destination = 7
#           Output: (1,2,6,7)
#   Source (1) is part of route [1,2,6] so the journey looks like 1 -> 2 -> 6
#   then jump to route [5,6,7] and takes the route 6 -> 7.
#   So the final route is (1,2,6,7)
# Example 2: Input: @routes = ([1,2,3], [4,5,6]) $source = 2 $destination = 5
#           Output: -1
# Example 3: Input: @routes = ([1,2,3], [4,5,6], [3,8,9], [7,8]) $source = 1 $destination = 7
#           Output: (1,2,3,8,7)
#   Source (1) is part of route [1,2,3] so the journey looks like 1 -> 2 -> 3
#   then jump to route [3,8,9] and takes the route 3 -> 8
#   then jump to route [7,8] and takes the route 8 -> 7
#   So the final route is (1,2,3,8,7)
# -----------------------------------
# Flatten the set of routes to form the entire graph, then do a path
# search in the total graph.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $Source;
my $Destination;

package Graph;
{
use builtin qw/true false/; no warnings "experimental::builtin";

    use Moo;
    use Carp qw/confess/;

    has adj => ( is => 'rw', default => sub{ {} } );

    sub show($self)
    {
        for my $node ( sort keys %{$self->{adj}} )
        {
            say "$node --> [ ", join(",", sort $self->{adj}{$node}->@*), " ]";;
        }
    }

    sub addNode($self, $n)
    {
        $self->{adj}{$n} //= [];
    }

    sub addEdge($self, $v1, $v2)
    {
        $self->addNode($v1);
        my $neighbors = $self->{adj}{$v1};
        push @{$neighbors}, $v2 unless grep { $_ == $v2 } $neighbors->@*;
        return $self;
    }

    sub hasNode($self, $n)
    {
        return exists $self->{adj}{$n};
    }

    sub route($self, $source, $destination)
    {
        no warnings "experimental::builtin";
        use List::Util qw/uniq/;
        return [ $source] if ( $source == $destination );

        # Breadth-first search
        my @path;
        my @queue = ( $source );
        my %seen;

        while ( @queue )
        {
            my $node = shift @queue;
            push @path, $node;

            my $neighbors = $self->{adj}{$node};
            for my $neighbor ( grep { !$seen{$_} } $neighbors->@* )
            {
                say "Q:[@queue] P:[@path] n:$neighbor" if $Verbose;
                if ( $neighbor == $destination )
                {
                    return [ @path, $neighbor ];
                }
                push @queue, $neighbor;
            }

            $seen{$node} = true;
        }
        return [];
    }
}

package main;

use Graph;

sub shortestRoute($segments, $source, $destination)
{
    my $g = Graph->new;
    for my $route ( $segments->@* )
    {
        my $v1 = shift @$route;
        $g->addNode($v1);
        while ( @$route )
        {
            my $v2 = shift @$route;
            $g->addEdge($v1,$v2)->addEdge($v2,$v1);
            $v1 = $v2;
        }
    }
    $g->show if $Verbose;
    return [] unless $g->hasNode($source) && $g->hasNode($destination);
    return $g->route($source, $destination);
}

GetOptions("test" => \$DoTest, "verbose" => \$Verbose,
           "source:i" => \$Source, "dest:i" => \$Destination);
exit(!runTest()) if $DoTest;

my @routeList;
push @routeList, [ split(",", $_) ] for @ARGV;

say "(", join(",", shortestRoute(\@routeList, $Source, $Destination)->@*), ")";

sub runTest
{
    use Test2::V0;

    is( shortestRoute( [[1,2,6],[5,6,7]],               1, 7), [1,2,6,7],   "Example 1");
    is( shortestRoute( [[1,2,3],[4,5,6]],               3, 6), [],          "Example 2");
    is( shortestRoute( [[1,2,3],[4,5,6],[3,8,9],[7,8]], 1, 7), [1,2,3,8,7], "Example 3");
    is( shortestRoute( [[1,2,6,7],[5,6,7],[1,2,6,7]],   1, 7), [1,2,6,7],   "Redundant edges");
    is( shortestRoute( [[1,2,3]], 2, 2), [2], "Going nowhere");
    is( shortestRoute( [[2]], 2, 2), [2], "Going nowhere faster");

    done_testing;
}
