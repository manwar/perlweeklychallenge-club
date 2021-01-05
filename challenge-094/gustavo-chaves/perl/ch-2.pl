#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-094/

use 5.030;
use warnings;

sub flatten_tree {
    my ($list, $tree) = @_;

    return unless defined $tree;

    my ($number, $left, $right) = @$tree;

    push @$list, $number;
    flatten_tree($list, $left);
    flatten_tree($list, $right);
}

my @list;

flatten_tree(\@list, [1, [2, [4], [5, [6], [7]]], [3]]);

$, = ' -> ';
say @list;
