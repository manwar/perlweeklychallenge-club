#!/usr/bin/env perl
#
# ch-2.pl - Path Sum
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

my $tree = make_random_tree(degree => 3, height => 4);
print_tree($tree);

my $sum = 30;
my @paths = path_sum($tree, $sum);

say "\nResults:";
if (@paths) {
    say join(' + ', @$_) . " = $sum" for @paths;
} else {
    say "No path found that equals $sum";
}

# Does a certain complete sum exist in the tree?
sub path_sum {
    my ($tree, $sum_left, @path) = @_;
    my ($val, @kids) = @$tree;
    push @path, $val;
    $sum_left -= $val;
    return [@path] if $sum_left == 0 and !@kids;
    return         if $sum_left <  0;

    map { path_sum($_, $sum_left, @path) } @kids;
}

#
# Helpers
# 

# Print a tree. Traverse from top.
sub print_tree {
    my ($node, $depth) = @_;
    my @node = @$node;
    printf "%s%02d\n", '| ' x $depth, shift @node;
    print_tree($_, $depth + 1) for @node;
}

# Makes a random tree of specified degree and height
# degree:   maximum number of nodes at each stage
#    2
#  1   5
# 3   6 7
#
# [2, [1, [3]], [5, [6], [7]]]
sub make_random_tree {
    my %a = (
        degree  => 2,
        height  => 5,
        prune   => sub { my %a = @_; 1 + rand $a{height}**5.2 < $a{depth}**5 },
        range   => 20,
        @_
    );

    return if $a{depth}++ == $a{height} or $a{prune}(%a);

    [ int rand $a{range} => map { make_random_tree(%a) } 1..$a{degree} ];
}
