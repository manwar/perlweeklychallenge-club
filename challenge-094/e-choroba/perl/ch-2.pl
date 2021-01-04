#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

=head1 Binary Tree to Linked List

As I understand it, the linked list should correspond to the
depth-first traversal of the tree.

Let's represent each node in a tree by an array reference where the
elements are VALUE, FIRST CHILD, SECOND CHILD, only the first one is
required. A tree is represented by its root.

Let's represent each element of a linked list by an array reference
where the elements are VALUE and NEXT. A linked list is represented by
its first element.

=cut

use enum qw( VALUE FIRST_CHILD SECOND_CHILD NEXT=1 );

sub bt2l {
    my ($tree) = @_;
    return unless defined $tree;

    return $tree->[VALUE],
           bt2l($tree->[FIRST_CHILD]),
           bt2l($tree->[SECOND_CHILD])
}

sub bt2ll {
    my ($tree) = @_;
    my @list = bt2l($tree);
    my $ll = my $element = [];
    for my $i (0 .. $#list) {
        $element->[VALUE] = $list[$i];
        $element = $element->[NEXT] = [] unless $i == $#list;
    }
    return $ll
}

sub to_string {
    my ($ll) = @_;
    return unless $ll;

    return join ' -> ', $ll->[VALUE], to_string($ll->[NEXT])
}

use Test::More tests => 2;
is_deeply bt2ll([1, [2, [4], [5, [6], [7]]], [3]]),
    [1, [2, [4, [5, [6, [7, [3]]]]]]],
    'Example 1';

is to_string(bt2ll([1, [2, [4], [5, [6], [7]]], [3]])),
    '1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3',
    'String representation';
