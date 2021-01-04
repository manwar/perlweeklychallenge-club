#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

my %nodes = map { $_ => Node->new($_) } 1 .. 7;

$nodes{1}->left( $nodes{2} );
$nodes{1}->right( $nodes{3} );

$nodes{2}->left( $nodes{4} );
$nodes{2}->right( $nodes{5} );

$nodes{5}->left( $nodes{6} );
$nodes{5}->right( $nodes{7} );

say join ' -> ', flatten_tree( $nodes{1} );

# THIS LOOKS LIKE A JOB FOR RECURSION!

# $tree is a node object, presumed to be the root of the
# tree. This code does not determine that, but something
# like while ( ! $node->is_root ) { $node = $node->parent }
# would solve it, as would iterating through the hash keys
# and finding the value(s) that is_root.

sub flatten_tree( $tree ) {
    my @array;

    # every node has value, and that comes first.
    push @array, $tree->value;

    # we prioritize the left branch over the right,
    # recursing on that.
    push @array, flatten_tree( $tree->left )
        if ( defined $tree->left );

    # we go left as our last choice.
    push @array, flatten_tree( $tree->right )
        if ( defined $tree->right );

    # wantarray is good and fun, determining if the
    # caller wants an array or not, and giving the
    # right response. Not usually THE thing that 
    # solves the problem in question, but helpful
    # for bookkeeping issues.
    return wantarray ? @array : \@array;
}

# trees from my challenge 57, with the slightest revision

package Node;

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value}  = $value;
    $self->{left}   = undef;
    $self->{right}  = undef;
    $self->{parent} = undef;
    return bless $self, $class;
}

sub value ( $self ) {
    return $self->{value};
}

sub is_root ( $self ) {
    return defined $self->{parent} ? 0 : 1;
}

sub is_leaf ( $self ) {
    return !defined $self->{left} && !defined $self->{right} ? 1 : 0;
}

sub left ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{left}   = $node;
        $node->{parent} = $self;
    }
    else {
        return $self->{left};
    }
}

sub right ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{right}  = $node;
        $node->{parent} = $self;
    }
    else {
        return $self->{right};
    }
}

sub parent ($self ) {
    return $self->{parent};
}
