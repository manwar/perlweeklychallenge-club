#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

my %node;
for my $i (
    qw{
    1/1 1/2 2/1
    1/3 3/2 2/3
    3/1 1/4 4/3
    3/5 5/2 2/5
    5/3 3/4 4/1
    }
    )
{
    $node{$i} = Node->new($i);
}

$node{'1/1'}->left( $node{'1/2'} );    # 1
$node{'1/1'}->right( $node{'2/1'} );   # 1

$node{'1/2'}->left( $node{'1/3'} );    # 2
$node{'1/2'}->right( $node{'3/2'} );   # 2

$node{'1/3'}->left( $node{'1/4'} );    # 3
$node{'1/3'}->right( $node{'4/3'} );   # 3

$node{'2/1'}->left( $node{'2/3'} );    # 2
$node{'2/1'}->right( $node{'3/1'} );   # 2

$node{'2/3'}->left( $node{'2/5'} );    # 3
$node{'2/3'}->right( $node{'5/3'} );   # 3

$node{'3/1'}->left( $node{'3/4'} );    # 3
$node{'3/1'}->right( $node{'4/1'} );   # 3

$node{'3/2'}->left( $node{'3/5'} );    # 3
$node{'3/2'}->right( $node{'5/2'} );   # 3

for my $n ( sort keys %node ) {
    my $node        = $node{$n};
    my $parent      = '';
    my $grandparent = '';
    if ( defined $node->parent ) {
        $parent = $node->parent->value;
        if ( defined $node->parent->parent ) {
            $grandparent = $node->parent->parent->value;
        }
    }
    say <<"END";
    INPUT: \$member = "$n"
    OUTPUT: parent = "$parent" and grandparent = "$grandparent"
END
}

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
