#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

use JSON;
my $json = JSON->new;

my @examples;
push @examples, [ [ 1, 2, 3 ], [ 3, 2, 1 ], ];
push @examples, [ [ 1, 2, 3, 4, 5 ], [ 6, 5, 5 ], ];

for my $e (@examples) {
    my ( $l1, $l2 ) = $e->@*;
    my $ll1 = create_linked_list($l1);
    my $ll2 = create_linked_list($l2);
    my $added = add_linked_lists( $ll1, $ll2 );
    print 'L1:      ';
    print_list($ll1);
    print 'L2:      ';
    print_list($ll2);
    print 'Output:  ';
    print_list($added);
    say '';
}

sub add_linked_lists ( $ll1, $ll2 ) {
    my $root;
    my $remainder = 0;
    while ( defined $ll1 ) {
        my $v1;
        my $v2;
        if ( defined $ll1 ) {
            $v1  = $ll1->value();
            $ll1 = $ll1->right();
        }
        else { $v1 = 0; }

        if ( defined $ll2 ) {
            $v2  = $ll2->value();
            $ll2 = $ll2->right();
        }
        else { $v2 = 0; }

        my $vv = $v1 + $v2 + $remainder;
        my $v  = $vv % 10;
        $remainder = int( $vv / 10 );

        my $node = Node->new($v);
        $node->right($root);
        $root = $node;

    }
    return $root;
}

sub create_linked_list( $ref ) {
    my $root;
    for my $v ( $ref->@* ) {
        my $node = Node->new($v);
        $node->right($root);
        $root = $node;
    }
    return $root;
}

sub print_list ( $node ) {
    print '>> ';
    while ( defined $node ) {
        print $node->value();
        print ' -> ' if defined $node->right();
        $node = $node->right();
    }
    say ' <<';
}

# if we ignore left() and parent(), Node works as a singly-linked list

package Node;

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value}      = $value;
    $self->{left}       = undef;
    $self->{right}      = undef;
    $self->{horizontal} = undef;
    $self->{parent}     = undef;
    return bless $self, $class;
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
