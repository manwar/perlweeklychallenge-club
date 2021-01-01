#!/usr/bin/env perl
#
# You are given binary tree containing numbers 0-9 only.
# Write a script to sum all possible paths from root to leaf.

use v5.30;
use warnings;

use Test::More;

use List::Util 'sum';

sub find_path_sums {
    my ($tree, $node_key, $path_sum) = @_;

    $path_sum += $node_key;
    my $node = $tree->{$node_key};
    my @path_sums;
    if (!defined $node->{left} and !defined $node->{right}) {
        @path_sums = ($path_sum);
        return \@path_sums;
    }
    push @path_sums, find_path_sums($tree, $node->{left}, $path_sum)->@* if $node->{left};
    push @path_sums, find_path_sums($tree, $node->{right}, $path_sum)->@* if $node->{right};

    return \@path_sums;
}

sub sum_path {
    my ($tree) = @_;

    my $root_node = do {
        my %values = %$tree;
        delete @values{($_->{left} // (), $_->{right} // ())} foreach values %$tree;
        (keys %values)[0];
    };

    my @paths_sums = find_path_sums($tree, $root_node, 0)->@*;
    return sum(@paths_sums);
}


# example 1
my %tree = (
    1 => { left => 2 },
    2 => { left => 3, right => 4 },
    3 => {},
    4 => {},
);

is sum_path(\%tree), 13, '1st example';


# example 2
%tree = (
    1 => { left => 2, right => 3 },
    2 => { left => 4 },
    3 => { left => 5, right => 6 },
    4 => {},
    5 => {},
    6 => {},
);

is sum_path(\%tree), 26, '2nd example';

done_testing();
