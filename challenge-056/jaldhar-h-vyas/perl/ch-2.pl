#!/usr/bin/perl

package Node;
use Moo;
use namespace::clean;

has left => (
    is => 'ro',
    isa => sub { (defined $_ && $_->isa('Node')) || undef },
);

has right => (
    is => 'ro',
    isa => sub { (defined $_ && $_->isa('Node')) || undef },
);

has amount => (
    is => 'ro',
);

1;

package main;
use 5.010;
use warnings;
use strict;

sub sum {
    my $total = 0;

    for my $elem (@{ $_[0] }) {
        $total += $elem;
    }

    return $total;
}

sub traverse {
    my ($node, $path, $target) = @_;
    my $path_copy = [ @{$path} ];

    push @{$path_copy}, $node->amount;

    unless ($node->left || $node->right) {
        if (sum($path_copy) == $target) {
            say join ' -> ', @{$path_copy};
        }
        return;
    }

    if ($node->left) {
        traverse($node->left, $path_copy, $target);
    }

    if ($node->right) {
        traverse($node->right, $path_copy, $target);
    }
}

my $node = Node->new(
    left => Node->new(
        left => Node->new(
            left => Node->new(
                left => undef,
                right => undef,
                amount => 7
            ),
            right => Node->new(
                left => undef,
                right => undef,
                amount => 2
            ),
            amount => 11
        ),
        right => undef,
        amount => 4
    ),
    right => Node->new(
        left => Node->new(
            left => undef,
            right => undef,
            amount => 13
        ),
        right => Node->new(
            left => undef,
            right => Node->new(
                left => undef,
                right => undef,
                amount => 1
            ),
            amount => 9
        ),
        amount => 8
    ),
    amount => 5
);

traverse($node, [], 22);
