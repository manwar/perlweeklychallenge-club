#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

sub tsp {
    die if @_ != 1;
    my @G = @{+shift};

    my @visited = map { 0 } @G;
    my %best = ( cost => (~0 >> 1), path => '' );

    my $minimum_weight_Hamiltonian_cycle;
    $minimum_weight_Hamiltonian_cycle = sub {
        my ( $current_position, $count, $cost_so_far, @path ) = @_;

        my $current_row = $G[$current_position];

        return if ($cost_so_far + $current_row->[0]) > $best{cost};

        if ($count == @G and $current_row->[0]) {
            my $cost = $cost_so_far + $current_row->[0];
            %best = ( cost => $cost, path => join(' ', @path) ) if $cost < $best{cost};
            return; # End of recursion.
        }

        for my $i ( grep { !$visited[$_] } keys @visited ) {
            my $node_cost = $current_row->[$i]
                or next; # Zero would mean same node, or no path from one node to next.

            $visited[$i] = 1;
            $minimum_weight_Hamiltonian_cycle->( $i, $count + 1, $cost_so_far + $node_cost, (@path, $i) );
            $visited[$i] = 0;
        }
    };

    $visited[0] = 1;
    $minimum_weight_Hamiltonian_cycle->( 0, 1, 0, );

    return %best;
}

my @tests = (
    [
        [ 0, 5, 2, 7 ],
        [ 5, 0, 5, 3 ],
        [ 3, 1, 0, 6 ],
        [ 4, 5, 4, 0 ],
    ],

    # https://people.sc.fsu.edu/~jburkardt/datasets/tsp/tsp.html , P01
    # Runs in 1m02s
    [
        [ qw<  0 29 82 46 68 52 72 42 51 55 29 74 23 72 46 > ],
        [ qw< 29  0 55 46 42 43 43 23 23 31 41 51 11 52 21 > ],
        [ qw< 82 55  0 68 46 55 23 43 41 29 79 21 64 31 51 > ],
        [ qw< 46 46 68  0 82 15 72 31 62 42 21 51 51 43 64 > ],
        [ qw< 68 42 46 82  0 74 23 52 21 46 82 58 46 65 23 > ],
        [ qw< 52 43 55 15 74  0 61 23 55 31 33 37 51 29 59 > ],
        [ qw< 72 43 23 72 23 61  0 42 23 31 77 37 51 46 33 > ],
        [ qw< 42 23 43 31 52 23 42  0 33 15 37 33 33 31 37 > ],
        [ qw< 51 23 41 62 21 55 23 33  0 29 62 46 29 51 11 > ],
        [ qw< 55 31 29 42 46 31 31 15 29  0 51 21 41 23 37 > ],
        [ qw< 29 41 79 21 82 33 77 37 62 51  0 65 42 59 61 > ],
        [ qw< 74 51 21 51 58 37 37 33 46 21 65  0 61 11 55 > ],
        [ qw< 23 11 64 51 46 51 51 33 29 41 42 61  0 62 23 > ],
        [ qw< 72 52 31 43 65 29 46 31 51 23 59 11 62  0 59 > ],
        [ qw< 46 21 51 64 23 59 33 37 11 37 61 55 23 59  0 > ],
    ],
);
for (@tests) {
    my %best = tsp($_);
    say join ' : ', @best{qw<cost path>};
}
