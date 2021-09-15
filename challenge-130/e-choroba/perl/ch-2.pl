#!/usr/bin/perl
use warnings;
use strict;

{   package Node;
    use Moo;
    use List::Util qw{ min max all };
    use namespace::clean;


    has [qw[ left right ]]  => (is => 'ro', predicate => 1);
    has [qw[ subtree_min  subtree_max ]]  => (is => 'lazy');
    has key => (is => 'ro', required => 1);

    sub is_bst {
        my ($self) = @_;

        return 0 if $self->has_left  && $self->left->subtree_max  > $self->key
                 || $self->has_right && $self->right->subtree_min < $self->key;

        return (all { $_->is_bst } $self->_children) ? 1 : 0
    }

    sub _children {
        my ($self) = @_;
        my @children;
        push @children, $self->left  if $self->has_left;
        push @children, $self->right if $self->has_right;
        return @children
    }

    sub _build_subtree_min {
        my ($self) = @_;
        my @children = $self->_children;

        return $self->key unless @children;
        return min(map $_->subtree_min, @children)
    }

    sub _build_subtree_max {
        my ($self) = @_;
        my @children = $self->_children;

        return $self->key unless @children;
        return max(map $_->subtree_min, @children)
    }
}

use Test2::V0;
plan 3;

my $tree1 = 'Node'->new(
    key   => 8,
    left  => 'Node'->new(
        key => 5,
        left  => 'Node'->new(key => 4),
        right => 'Node'->new(key => 6)
    ),
    right => 'Node'->new(key => 9));
is $tree1->is_bst, 1, 'Example 1';

my $tree2 = 'Node'->new(
    key   => 5,
    left  => 'Node'->new(
        key   => 4,
        left  => 'Node'->new(key => 3),
        right => 'Node'->new(key => 6)
    ),
    right => 'Node'->new(key => 7));

is $tree2->is_bst, 0, 'Example 2';

my $tree3 = 'Node'->new(
    key => 10,
    left => $tree2,
    right => 'Node'->new(key => 11));
is $tree3->is_bst, 0, 'Deeper';
