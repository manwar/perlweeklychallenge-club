#!/usr/bin/env perl
use warnings;
use v5.12;

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::AllUtils qw(max_by);

sub lr($tree) {
    (scalar @{$tree} < 3 || $tree->[0] eq '.') && return [[],[]];
    (scalar @{$tree} == 3) && return [["."],["."]];
    my @left;
    my ($sum,$ix)=(0,1);
    while ($sum != -1) {
	push @left, $tree->[$ix];
	$sum+=(($tree->[$ix] eq '.') ? (-1) : (1));
	$ix++;
    }
    my @right = $tree->@[(scalar @left)+1..(scalar @{$tree})-1];
    return [\@left,\@right];
}

sub lrLongPath($tree) {
    $tree->[0] eq '.' && return [[],[]];
    scalar @{$tree} == 3 && return [[$tree->[0]],[$tree->[0]]];
    my ($left,$right) = @{lr($tree)};
    my $lLongPath = max_by {scalar @{$_}} @{lrLongPath($left)};
    my $rLongPath = max_by {scalar @{$_}} @{lrLongPath($right)};
    my @lLongPath = ($tree->[0],@{$lLongPath});
    my @rLongPath = ($tree->[0],@{$rLongPath});
    return [\@lLongPath,\@rLongPath];
    
}

sub biLongPath($tree) {
    (scalar @{$tree} < 3 || $tree->[0] eq '.') && return [];
    (scalar @{$tree} == 3) && return [$tree->[0]];
    my ($lPath,$rPath) = @{lrLongPath($tree)};
    my @lPath = reverse $lPath->@[1..(scalar @{$lPath})-1];
    my @path = (@lPath,@{$rPath});
    my ($left,$right) = @{lr($tree)};
    return max_by {scalar @{$_}} (\@path, map {biLongPath($_)} ($left,$right));
}

my $sol = biLongPath(\@ARGV);
say "@{$sol}";

__END__
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
