#!/usr/bin/perl
use warnings;
use strict;

# In a tree. the "root distance" is usually called a "rank".

{   package Tree;
    use Moo;

    has root => (is => 'ro');
    has parent => (is => 'lazy');

    sub add_child {
        my ($self, $value, $parent) = @_;
        die "Unknown parent $parent" unless exists $self->parent->{$parent};

        die "Duplicate parent for $value" if defined $self->parent->{$value}
                                          && $self->parent->{$value} != $parent;

        $self->parent->{$value} = $parent;
    }

    sub rank {
        my ($self, $value) = @_;
        return 0 unless $self->parent->{$value};

        return 1 + $self->rank($self->parent->{$value})
    }

    sub _build_parent {
        my ($self) = @_;
        +{ $self->root => 0 }
    }
}

use Test2::V0;
plan 11;

my $tree1 = 'Tree'->new(root => 1);
$tree1->add_child(@$_) for [2, 1], [3, 1], [4, 3], [5, 4], [6, 4];

is $tree1->rank(6), 3, 'Example 1a';
is $tree1->rank(5), 3, 'Example 1b';
is $tree1->rank(2), 1, 'Example 1c';
is $tree1->rank(4), 2, 'Example 1d';

my $tree2 = 'Tree'->new(root => 1);
$tree2->add_child(@$_) for [2, 1], [4, 2], [6, 4], [8, 6],
                           [9, 6], [3, 1], [5, 3], [7, 5];
is $tree2->rank(7), 3, 'Example 2a';
is $tree2->rank(8), 4, 'Example 2b';
is $tree2->rank(6), 3, 'Example 2c';

is $tree1->rank(1), 0, 'Root';
is $tree2->rank(1), 0, 'Root';

my $tree3 = 'Tree'->new(root => 1);
like dies { $tree3->add_child(3, 2) },
    qr/Unknown parent 2/,
    'unknown root';

my $tree4 = 'Tree'->new(root => 1);
$tree4->add_child(2, 1);
like dies { $tree4->add_child(1, 2) },
    qr/Duplicate parent for 1/,
    'duplicate parent';
