#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Graph::Undirected;
use List::Util qw{ max };

sub contiguous_block($matrix) {
    my $g = 'Graph::Undirected'->new;
    for my $y (0 .. $#$matrix) {
        for my $x (0 .. $#{ $matrix->[$y] }) {
            $g->add_vertex("$x $y");
            for my $neighbour ([$x + 1, $y], [$x, $y + 1]) {
                my ($i, $j) = @$neighbour;
                $g->add_edge("$x $y", "$i $j")
                    if $matrix->[$y][$x] eq ($matrix->[$j][$i] // "");
            }
        }
    }
    return max(map scalar @$_, $g->connected_components)
}

use Test::More tests => 3 + 1;

is contiguous_block([
    ['x', 'x', 'x', 'x', 'o'],
    ['x', 'o', 'o', 'o', 'o'],
    ['x', 'o', 'o', 'o', 'o'],
    ['x', 'x', 'x', 'o', 'o'],
]), 11, 'Example 1';

is contiguous_block([
    ['x', 'x', 'x', 'x', 'x'],
    ['x', 'o', 'o', 'o', 'o'],
    ['x', 'x', 'x', 'x', 'o'],
    ['x', 'o', 'o', 'o', 'o'],
]), 11, 'Example 2';

is contiguous_block([
    ['x', 'x', 'x', 'o', 'o'],
    ['o', 'o', 'o', 'x', 'x'],
    ['o', 'x', 'x', 'o', 'o'],
    ['o', 'o', 'o', 'x', 'x'],
]), 7, 'Example 3';

is contiguous_block([
    [qw[ o x o o x x o x o o x x o x x x x x o x o o o x x x x x x o x x x o ]],
    [qw[ x o o o x x x o o x x o x x o o x o o o x x o x x x x x o x x x o o ]],
    [qw[ o o x o x x x o o x x x o x x x o o x o x x o x x x x o o x o o o o ]],
    [qw[ x x x o x o o o x x o o x x o x o x x x x o o x x x x x o x o x x x ]],
    [qw[ o x o x x x x o x o x o x o x o x o x x o x o o o o o x o o o o x x ]],
    [qw[ o o x o o o o x x o x o x x x x x o o o o o x o x x x o x o o o x x ]],
    [qw[ o o o x o o x o o o x o x x x x x x x o x x o o o o o o x o x o x o ]],
    [qw[ o o x x o x x x o x o x x o o x x x x o o o o o x o o o o o o o x o ]],
    [qw[ o x o o x o o x o x o x o x o x o o o o x o o o o o o o o o x o x o ]],
    [qw[ x o x x x o x x x x x o o o o x x x o x x o o o x x o o x x o x x o ]],
    [qw[ o o o x o o x o o o o o o o x x o o x o o x x o o o o x x x x o o x ]],
    [qw[ x x x o o o o o x o o x o o x x o x x o o o o x o x x o o o x x o o ]],
    [qw[ o x o x x o o x x x o o o o o o x x x o x x o x x x x o x o x o x o ]],
    [qw[ o x o x x o o o o o o o o x o o x x x x o o o x x x x x o x x x x x ]],
    [qw[ o o x o x o o o x x o x o o x o x x o x x o x o x o x o o o o x x x ]],
    [qw[ o x o x o o x x o x x x o o x x o x x x o x o o x x x o o o o x o o ]],
    [qw[ x x x o o o x o o x x o x x o o x x o o x x x o x o o x x x x o x x ]],
    [qw[ o x x o x o o x o o o o o o x o x o o o o o o x o x x x x x o o o x ]],
    [qw[ o o o x x x o o o o x o o x o o o o x x x o x x o o o x x x x x o x ]],
    [qw[ o x x x o x o o x o x x o o o x o o x o x x o o o o o x o x x o o x ]],
    [qw[ x x x x o o o x x x o x o o x o o x x o x x x o o o x x x x o o x o ]],
    [qw[ x x o o o o o x x x o o o x o o o x x o o x o o x o x o x o o o o o ]],
    [qw[ o x o o x x o x o x o x o o o o o x o o o o o x o x o x x x x x o o ]],
    [qw[ x x o o x o o o x o o o x o o o x x o o x x o x x x o o x x o o x o ]],
    [qw[ x o o o x x x o x o x x x o o o x x o o x x x o x x x x o x x x o x ]],
    [qw[ o x o o x x o o o o x x x x o o o o x o o o x o o o o o o x x o x o ]],
    [qw[ x x o x x o x x o x o x x x x o o o x o x x x x o x x x o o x o x o ]],
    [qw[ x x x o o o x o o x o x o o o o o x o o x x o x o x o x x o x x x x ]],
    [qw[ o o x o o x o x o x o x o o x x x x o o o x o x x x x x x o x x x x ]],
    [qw[ x o o o x o x x x o o x x o x o o x o x x o x x o x x x x o x x o o ]],
    [qw[ x o o x x o o o o o x o x x o x x o o o o x x o x o x x o x o o o o ]],
    [qw[ x x x x o o x o o x x o o x x x o x x x x o o o x x x x o x o o o o ]],
    [qw[ o o o o x o o o o x o o x x x x o o o o x x x x x x x o x x x o x x ]],
    [qw[ x o x o x o o x x o o o o o o x x x x x x o o o x x o x o x x x o o ]],
]), 178, 'Large';
