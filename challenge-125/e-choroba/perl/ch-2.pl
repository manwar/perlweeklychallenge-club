#! /usr/bin/perl
use warnings;
use strict;

{   package Node;
    use Moo;
    use List::Util qw{ max sum };
    use namespace::clean;

    has value => (is => 'ro');
    has [qw[ left right ]] => (is => 'rw');

    sub new_from_structure {
        my ($class, $structure) = @_;
        my $self = $class->new(value => $structure->[0]);
        my @ch = @{ $structure->[1] };
        if (defined $ch[0][0]) {
            my $left  = $ch[0][1]
                ? 'Node'->new_from_structure([$ch[0][0], $ch[0][1]])
                : 'Node'->new(value => $ch[0][0]);
            $self->left($left);
        }
        if (defined $ch[1][0]) {
            my $right  = $ch[1][1]
                ? 'Node'->new_from_structure([$ch[1][0], $ch[1][1]])
                : 'Node'->new(value => $ch[1][0]);
            $self->right($right);
        }
        return $self
    }

    sub children {
        my ($self) = @_;
        return grep defined, $self->left, $self->right
    }

    sub max_depth {
        my ($self) = @_;
        return 1 + max(0, map $_->max_depth, $self->children)
    }

    sub diameter {
        my ($self) = @_;
        my $branch_here = sum(0, map $_->max_depth, $self->children);
        my @diameters = map $_->diameter, $self->children;
        return max(@diameters, $branch_here)
    }
}

use Test2::V0;
plan 3;

my $root1 = 'Node'->new_from_structure(
    [1, [[2, [[3], [4]]], [5, [[6], [7, [[8, [[9]]], [10]]]]]]]);
is $root1->diameter, 6, 'Example 1';

my $root2 = 'Node'->new(value => 1);
is $root2->diameter, 0, 'Single node';

my $root3 = 'Node'->new_from_structure([1, [[2, [[3, [[5]]], [4, [[6]]]]]]]);
is $root3->diameter, 4, 'Not passing through the root';
