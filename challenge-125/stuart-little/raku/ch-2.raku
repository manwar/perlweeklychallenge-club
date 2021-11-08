#!/usr/bin/env raku
use v6;

sub lr(@tree) {
    (@tree.elems < 3 || @tree[0] eq '.') && return [[],[]];
    (@tree.elems == 3) && return [["."],["."]];
    my @left;
    my ($sum,$ix)=(0,1);
    while ($sum != -1) {
	@left.push(@tree[$ix]);
	$sum+=((@tree[$ix] eq '.') ?? (-1) !! (1));
	$ix++;
    }
    my @right = @tree[@left.elems^..^@tree.elems];
    return [@left,@right];
}

sub lrLongPath(@tree) {
    @tree[0] eq '.' && return [[],[]];
    @tree.elems == 3 && return [[@tree[0]],[@tree[0]]];
    my ($left,$right) = lr(@tree);
    my $lLongPath = [@tree[0], |(lrLongPath($left).max({ $_.elems }))];
    my $rLongPath = [@tree[0], |(lrLongPath($right).max({ $_.elems }))];
    return [$lLongPath,$rLongPath];    
}

sub biLongPath(@tree) {
    (@tree.elems < 3 || @tree[0] eq '.') && return [];
    (@tree.elems == 3) && return [@tree[0],];
    my ($lPath,$rPath) = lrLongPath(@tree);
    my @lPath = $lPath.[1..*].reverse;
    my @path = [|@lPath,|$rPath];
    my ($left,$right) = lr(@tree);
    return (@path, |($left,$right).map({ biLongPath($_) })).max({ $_.elems });
}

my $sol = biLongPath(@*ARGS);
say $sol;

=finish
run <script> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 1 2 4 . 7 . . . 3 5 . . 6 . . represents the tree

        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2
