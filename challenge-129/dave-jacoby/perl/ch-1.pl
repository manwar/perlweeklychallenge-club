#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental };

# Planting the first tree
my %nodes;
for my $n ( 1 .. 6 ) {
    my $node = Node->new($n);
    $nodes{$n} = $node;
}
$nodes{1}->left( $nodes{2} );
$nodes{1}->right( $nodes{3} );
$nodes{3}->right( $nodes{4} );
$nodes{4}->left( $nodes{5} );
$nodes{4}->right( $nodes{6} );

say uc 'tree 1';
for my $n ( 1 .. 6 ) {
    my $d = root_distanced( \%nodes, $n );
    say qq{    Node:     $n};
    say qq{    Distance: $d};
    say '';
}

# Planting the second tree
%nodes = ();
for my $n ( 1 .. 9 ) {
    my $node = Node->new($n);
    $nodes{$n} = $node;
}
$nodes{1}->left( $nodes{2} );
$nodes{1}->right( $nodes{3} );
$nodes{2}->left( $nodes{4} );
$nodes{3}->right( $nodes{5} );
$nodes{4}->right( $nodes{6} );
$nodes{5}->left( $nodes{7} );
$nodes{6}->right( $nodes{8} );
$nodes{6}->right( $nodes{9} );

say uc 'tree 2';
for my $n ( 1 .. 9 ) {
    my $d = root_distanced( \%nodes, $n );
    say qq{    Node:     $n};
    say qq{    Distance: $d};
    say '';
}

exit;

# it's fairly simple. If the node is not the root, 
# we travel up (down?) the tree until we find the root.
sub root_distanced ( $nodes, $n ) {
    my $d    = 0;
    my $node = $nodes->{$n};
    while ( !$node->is_root() ) {
        $d++;
        $node = $node->parent();
    }
    return $d;
}

# OF COURSE I pull out my Node code!

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
