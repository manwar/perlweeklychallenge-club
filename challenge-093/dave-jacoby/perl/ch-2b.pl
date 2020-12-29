#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

# I always forget that trees are not hard, especially if you can
# keep track of the nodes outside of a tree. Here we create the
# nodes as part of a hash, connect the children as appropriate,
# then make an array of all the nodes, which know who their
# neighbors are and thus can be used to navigate through the tree

# this therefore doesn't do much with the

my @nodes;
{
    my %hash = map { $_ => Node->new($_) } 1 .. 4;
    $hash{1}->left( $hash{2} );
    $hash{2}->left( $hash{3} );
    $hash{2}->right( $hash{4} );
    @nodes = values %hash;
    say 'EXAMPLE 1';
    sum_paths(@nodes);
    say '';
}

{
    my %hash = map { $_ => Node->new($_) } 1 .. 6;
    $hash{1}->left( $hash{2} );
    $hash{1}->right( $hash{3} );
    $hash{2}->left( $hash{4} );
    $hash{3}->left( $hash{5} );
    $hash{3}->right( $hash{6} );
    @nodes = values %hash;
    say 'EXAMPLE 2';
    sum_paths(@nodes);
    say '';
}

exit;

sub sum_paths ( @array ) {
    my $sum = 0;    # we have no values yet

    # headers: a good suggestion
    my @headers = ( '', 'sum', 'value', 'leaf' );
    say join "\t", @headers;
    say join "\t", map { '=' x length $_ } @headers;

    # check every node, but we only care if it's a leaf
    for my $node (@array) {
        if ( $node->is_leaf ) {

            # if it IS a node, we copy the address and start
            # from there, going down to the root, and adding
            # the values of the nodes along the way
            my $n = $node;
            $sum += $n->value;
            while ( !$n->is_root ) {
                $n = $n->parent;
                $sum += $n->value;
            }

        }
        say join "\t", '', $sum, $node->value, $node->is_leaf;
    }
    say qq{OUTPUT: $sum};
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
