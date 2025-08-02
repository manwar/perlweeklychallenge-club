#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 295 Task 2: Jump Game
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

use Verbose;
# $verbose = 1;

use Algorithm::Functional::BFS;

sub jump_game_using_module( @ints ) {
    my @nodes = map [ $_ ], 0..$#ints;
    my $bfs = Algorithm::Functional::BFS->new (
        adjacent_nodes_func =>
            sub( $node ) {
                my $i = $node->[0];
                return [ reverse map $nodes[$_], $i .. $i + $ints[$i] ]
            },
        victory_func =>
            sub( $node ) { $node->[0] == $#ints },
        include_start_node => true,
        one_result => true,
    );
    my $routes = $bfs->search( $nodes[0] );
    return exists $routes->[0] ? scalar $routes->[0]->@* - 1 : -1;
}

sub jump_game( @ints ) {
    vsay pp @ints;
    my ( $index, $n_jumps ) = ( 0, 0 );
    my @queue = ( [ $index, $n_jumps ] );
    while ( @queue ) {
        my ( $index, $n_jumps ) = ( shift @queue )->@*;
        vsay "    " x $n_jumps, "trying [ $index, $n_jumps ]";
        return $n_jumps
            if $index == $#ints;
        push @queue,
            map [ $_, $n_jumps + 1 ],
                grep $_ <= $#ints,
                    reverse $index + 1 .. $index + $ints[$index];
        vsay "    " x $n_jumps, "queue ", pp @queue;
    }
    return -1;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is jump_game( 2, 3, 1, 1, 4 ), 2,
    'Example 1: jump_game( 2, 3, 1, 1, 4 ) == 2';
is jump_game( 2, 3, 0, 4 ), 2,
    'Example 2: jump_game( 2, 3, 0, 4 ) == 2';
is jump_game( 2, 0, 0, 4 ), -1,
    'Example 3: jump_game( 2, 0, 0, 4 ) == -1';
is jump_game( 0 ), 0,
    'Extra 1: jump_game( 0 ) == 0';

done_testing;
