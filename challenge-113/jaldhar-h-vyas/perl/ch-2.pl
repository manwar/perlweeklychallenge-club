#!/usr/bin/perl

package Node {
    use Moo;
    use namespace::autoclean;

    has parent => (
        is => 'ro',
        isa => sub { return ref eq 'Node' || undef; },
    );

    has left => (
        is => 'rw',
        isa => sub { return ref eq 'Node'; },
    );

    has right => (
        is => 'rw',
        isa => sub { return ref eq 'Node'; },
    );

    has value => (
        is => 'rw',
        isa => sub { return ref eq 'Node'; },
    );
}

package main;
use 5.020;
use warnings;

sub totalFrom {
    my ($node) = @_;
    my $sum = $node->value;

    if (defined $node->left) {
        $sum += totalFrom($node->left);
    }

    if (defined $node->right) {
        $sum += totalFrom($node->right);
    }

    return $sum;
}

sub replaceFrom {
    my ($node, $total) = @_;

    $node->value($total - $node->value);

    if (defined $node->left) {
        replaceFrom($node->left, $total);
    }

    if (defined $node->right) {
        replaceFrom($node->right, $total);
    }
}

sub output {
    my ($node, $left) = @_;

    if (defined $node->parent) {
        say q{}, ((defined $left) ? 'left' : 'right'), ' child of ', $node->parent->value, ' = ', $node->value;
    } else {
        say 'root = ', $node->value;
    }

    if (defined $node->left) {
        output($node->left, 1);
    }

    if (defined $node->right) {
        output($node->right);
    }
}

my $root = Node->new(parent => undef, value => 1);
$root->left(Node->new(parent => $root, value => 2));
$root->right(Node->new(parent => $root, value => 3));
$root->left->left(Node->new(parent => $root->left, value => 4));
$root->right->left(Node->new(parent => $root->right, value => 5));
$root->right->right(Node->new(parent => $root->right, value => 6));
$root->left->left->right(Node->new(parent => $root->left->left, value => 7));


my $total = totalFrom($root);

replaceFrom($root, $total);

output($root);
