#!/usr/bin/env perl

use strict;
use warnings;
use Tree::Binary;

=head1 NAME

PWC 093 Challenge 2

=head1 SYNOPSIS

  $ ch-2.pl
  32

=head1 DESCRIPTION

Given a binary tree containing numbers 0-9 only, this script will sum all
possible paths from root to leaf.

=head1 SOLUTION

For this solution, I did use the library Tree::Binary in order to provide quick
setup of a tree and a node object that would allow me to traverse the left and
right nodes.  This solution also does not allow for input to dynamically build
a tree (I couldn't see a good way of inputting data that would build a good
tree.)

Once the tree is built, a recursive method is called passing in a stack (as an
array) and the current node.  If this node is a leaf (the exit condition), then
we'll sum the current nodes value with all values in the stack and return that
total.  Otherwise, we'll push the current node value to the stack and try the
left and right branches, if they exist.  The total will be taken from the return
value.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my ($btree) = Tree::Binary -> new('1')
                -> setLeft
                        (
                                Tree::Binary -> new('0')
                                        -> setLeft(Tree::Binary->new('2') )
                        )
                -> setRight
                        (
                                Tree::Binary->new('9')
                                        -> setLeft(Tree::Binary->new('4') )
                                        -> setRight(Tree::Binary->new('5') )
                        );

print add_paths([], $btree) . "\n";
exit 0;

sub add_paths {
    my ($stack, $node) = @_;
    
    my $total = 0;
    if ($node->isLeaf()) {
        my $total = $node->getNodeValue();
        map { $total += $_; } @{$stack};
        return $total;
    } else {
        push(@{$stack}, $node->getNodeValue());
        $total += add_paths($stack, $node->getLeft()) if $node->hasLeft();
        $total += add_paths($stack, $node->getRight()) if $node->hasRight();
        pop(@{$stack});
    }
    return $total;
}
