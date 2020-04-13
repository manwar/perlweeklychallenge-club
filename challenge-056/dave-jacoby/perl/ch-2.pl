#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

# make the tree
my $hash->%* = map { $_ => new Node($_) } 1 .. 13;
$hash->{5}->add_child( $hash->{4} );
$hash->{5}->add_child( $hash->{8} );
$hash->{4}->add_child( $hash->{11} );
$hash->{11}->add_child( $hash->{7} );
$hash->{11}->add_child( $hash->{2} );
$hash->{8}->add_child( $hash->{13} );
$hash->{8}->add_child( $hash->{9} );
$hash->{9}->add_child( $hash->{1} );

spider_tree( $hash->{5}, 22 );

sub spider_tree ( $node, $value ) {
    if ( $node->is_leaf() ) {
        my $x = $node;
        my $t = $x->value();
        my @p = ( $x->value() );
        while ( !$x->is_root ) {
            $x = $x->parent();
            $t += $x->value();
            unshift @p, $x->value();
        }
        if ( $t == $value ) {
            say $t;
            say join ' -> ', @p;
        }
    }
    for my $child ( $node->children() ) {
        spider_tree( $child, $value );
    }
}

package Node;

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value}    = $value;
    $self->{children} = [];
    $self->{parent}   = undef;
    return bless $self, $class;
}

sub value ( $self ) {
    return $self->{value};
}

sub is_root ( $self ) {
    return defined $self->{parent} ? 0 : 1;
}

sub is_leaf ( $self ) {
    return scalar $self->{children}->@* ? 0 : 1;
}

sub add_child ( $self, $node ) {
    $node->{parent} = $self;
    push $self->{children}->@*, $node;
}

sub children( $self ) {
    return $self->{children}->@*;
}

sub parent ($self ) {
    return $self->{parent};
}
