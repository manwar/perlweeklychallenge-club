#!/usr/bin/perl
use warnings;
use strict;

sub binary_tree_depth {
    my ($string) = @_;

    my @levels = split /\|/, $string;
    shift @levels;

    my @parents = (my $id = 0);
    my %tree = ($id => {rank => my $rank = 0});

    for my $level (@levels) {
        ++$rank;
        my @nodes = split ' ', $level;
        my @next_parents;

        while (@nodes) {
            my %children;
            @children{qw{ left right }} = splice @nodes, 0, 2;
            for my $side (qw( left right )) {
                if (($children{$side} // '*') ne '*') {
                    $tree{ ++$id } = {rank   => $rank,
                                      parent => $parents[0]};
                    push @next_parents,
                        $tree{ $parents[0] }{$side} = $id;
                }
            }
            my $parent = shift @parents;

            return $rank if ! exists $tree{$parent}{left}
                         && ! exists $tree{$parent}{right};
        }
        return $rank if @parents;

        @parents = @next_parents;
    }
    return $rank + 1
}

use Test::More tests => 15;

is binary_tree_depth('1 | 2 3 | 4 5'), 2, 'Example 1';
is binary_tree_depth('1 | 2 3 | 4 *  * 5 | * 6'), 3, 'Example 2';

is binary_tree_depth('1'), 1, 'Trivial 1-node tree';
is binary_tree_depth('1 | 2'), 2, 'Simple 2-node tree';

is binary_tree_depth('1 | 2 3'), 2, 'Simple tree rank 2';
is binary_tree_depth('1 | 2 | 3'), 3, 'Linear depth 3';
is binary_tree_depth('1 | 2 | * 3'), 3, 'Zigzag';
is binary_tree_depth('1 | * 2 | 3'), 3, 'Zagzig';
is binary_tree_depth('1 | * 2 | * 3'), 3, 'Right linear depth 3';

is binary_tree_depth('1 | 2 3 | * * * *'), 2, 'All stars';

is binary_tree_depth('1 | 2 3 | * * 4 5'), 2, 'Missing left children';
is binary_tree_depth('1 | 2 3 | * * 4'), 2, 'Missing left children';
is binary_tree_depth('1 | 2 3 | * * * 4'), 2, 'Missing left children';
is binary_tree_depth('1 | 2 3 | 4 | 5 | 6'), 2, 'Short branch';

is binary_tree_depth('1 | 1 1 | 1 1 1 1 | 1 * 1 * 1 * 1'), 4, 'Repeated values';
