#!/usr/bin/perl
# Test: ./ch-1.pl 4
package BTree::Node; # Binary Tree

use strict;
use warnings;
use Mouse;

has 'value' => (
    is  => 'rw',
    isa => 'Maybe[Str]',
    default => sub { return undef; }
);

has 'left' => (
    is  => 'rw',
    isa => 'Maybe[BTree::Node]',
    default => sub { return undef }
);

has 'right' => (
    is  => 'rw',
    isa => 'Maybe[ BTree::Node]',
    default => sub { return undef }
);

__PACKAGE__->meta->make_immutable();

package BTree; # Binary Tree

use strict;
use warnings;
use Mouse;
use feature qw /say/;

has 'root' => (
    is  => 'rw',
    isa => 'BTree::Node',
    default => sub { BTree::Node->new() }
);

# Creates the Binary tree from the data
sub create_btree {
    my ($self, $data, $node) = @_;

    $node = $self->root
    	unless($node);

    # End of the line
    if (ref $data ne 'ARRAY') {
    	$node->value($data);
    	return;
    }

    # Value is contained in the first item of the list
    $node->value($data->[0]);

    # Left branch
    if ($data->[1]->[0]) {
    	$node->left( BTree::Node->new() );
    	$self->create_btree($data->[1]->[0], $node->left );
    }

    # Right branch
    if ($data->[1]->[1]) {
    	$node->right( BTree::Node->new() );
    	$self->create_btree($data->[1]->[1], $node->right );
    }
}

# Print the tree
sub print_tree {
    my ($self, $node) = @_;

    $node = $self->root
    	unless($node);

    my $left = ($node->left) ?
    	$self->print_tree($node->left) :
    	undef;

    my $right = ($node->right) ?
    	$self->print_tree($node->right) :
    	undef;

    my $lists = ($left || $right) ?
    	          ' => ' . "[ $left, $right ]" :
    	          '';

    return $node->value . $lists;
}

# Invert the tree
sub invert_tree {
    my ($self, $node) = @_;

    $node = $self->root
    	unless($node);

    # Branch left
    $self->invert_tree( $node->left )
    	if ($node->left);

    # Branch right
    $self->invert_tree( $node->right )
    	if ($node->right);

    # Invert the tree
    my $temp = $node->left;
    $node->left($node->right);
    $node->right($temp);

}

__PACKAGE__->meta->make_immutable();

package main;

use strict;
use warnings;
use feature qw /say/;

my $btree_data = [
    1 => [
    	[ 2 => [4 , 5] ],
    	[ 3 => [6 , 7] ],
    ]
];
my $btree = BTree->new();
my $node = $btree->root;

$btree->create_btree($btree_data);
say "Original: " . $btree->print_tree();
$btree->invert_tree();
say "Inverted: " . $btree->print_tree();
