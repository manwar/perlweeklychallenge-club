#!/usr/bin/env perl6

# ch-2.p6 - Path Sum
#
# Ryan Thompson <rjt@cpan.org>

#@tree = [10, [18, [5], [2]], [8, [16, [18]], [9]]];

my @tree = [6, [5, [2], [4, [15]]], [19, [4, [5]], [2, [12]]], [1, [16, [7]]]];

path-sum(@tree,30).say;

#| Does a certain complete sum exist in the tree?
sub path-sum( @tree, $sum is copy, @path is copy = [] ) {
    my ($val, @kids) = @tree;
    @path.push: $val;
    $sum -= $val;

    return @path if $sum == 0 and !@kids;
    return Empty if $sum <  0;

    |@kids.map: { path-sum($_, $sum, @path) };
}
