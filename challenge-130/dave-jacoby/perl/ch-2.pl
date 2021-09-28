#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

{
    say uc 'example 1';
    my $nodes;
    for my $v (qw( 4 5 6 8 9 )) {
        $nodes->{$v} = Node->new($v);
    }
    $nodes->{8}->left( $nodes->{5} );
    $nodes->{8}->right( $nodes->{9} );
    $nodes->{5}->left( $nodes->{4} );
    $nodes->{5}->right( $nodes->{6} );
    say $nodes->{8}->bst();
    say '';
}

{
    say uc 'example 2';
    my $nodes;
    for my $v (qw( 3 4 5 6 7 )) {
        $nodes->{$v} = Node->new($v);
    }
    $nodes->{5}->left( $nodes->{4} );
    $nodes->{5}->right( $nodes->{7} );
    $nodes->{4}->left( $nodes->{3} );
    $nodes->{4}->right( $nodes->{6} );
    say $nodes->{5}->bst();
    say '';
}

package Node;
use List::Util qw{sum0};

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value}      = $value;
    $self->{left}       = undef;
    $self->{right}      = undef;
    $self->{horizontal} = undef;
    $self->{parent}     = undef;
    return bless $self, $class;
}

# is_bst needs to have either an undefined value,
# indicating non-bst, or an array, to determination
# if the parent node is bst, but that's not the 
# output the task needs, so here we massage it into
# place
sub bst ( $self ) {
    my $o = $self->is_bst();
    return defined $o ? 1 : 0;
}

# if a node is a leaf, it's balanced
# otherwise, we get the values from the left and right
# we then filter them to remove any that would not be 
# in that list if the tree wasn't bst
# if the arrays aren't of equal size, return undef
# if the next level of nodes returns undef, return undef
# ultimate output will either be a sorted list of 
# values or undef, and that's basically true or false 
sub is_bst( $self ) {

    if ( $self->is_leaf ) {
        my $out = [];
        push $out->@*, $self->value;
        return $out;
    }

    my @left;
    my @right;
    if ( defined $self->left ) {
        my $local = $self->left()->is_bst();
        return undef if !defined $local;
        push @left, $local->@*;
    }
    if ( defined $self->right ) {
        my $local = $self->right()->is_bst();
        return undef if !defined $local;
        push @right, $local->@*;
    }
    my @left2  = grep { $_ < $self->value } @left;
    my @right2 = grep { $_ > $self->value } @right;

    return undef if scalar @left != scalar @left2;
    return undef if scalar @right != scalar @right2;
    return [ @left, $self->value, @right ];
}

sub distance ( $self ) {
    my $d    = 0;
    my $copy = $self;
    while ( !$copy->is_root ) {
        $copy = $copy->parent;
        $d++;
    }
    return $d;
}

sub value ( $self, $value = undef ) {
    if ( defined $value ) {
        $self->{value} = $value;
    }
    else {
        return $self->{value};
    }
}

sub is_root ( $self ) {
    return defined $self->{parent} ? 0 : 1;
}

sub is_leaf ( $self ) {
    return ( !defined $self->{left} && !defined $self->{right} )
        ? 1
        : 0;
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

sub horizontal ( $self, $node = undef ) {
    if ( defined $node ) {
        $self->{horizontal} = $node;
        $node->{parent}     = $self;
    }
    else {
        return $self->{horizontal};
    }
}

sub parent ($self ) {
    return $self->{parent};
}
