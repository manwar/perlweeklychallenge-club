#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

my @input;
push @input, '1 | 2 3 | 4 5';
push @input, '1 | 2 3 | 4 * * 5 | * 6';
push @input, '1 | 3 5 | 7 9 11';
push @input, '1 | 2 | 3 | 4 | 5 6 | * * 7 | * * * * 8';
push @input, '1 | 2 | 3 | 4 | 5 6 | * * 7 | * * * * * * 8';
push @input, '1 | 2 | 3 | 4 | 5 | 6 | 7 | 8';

for my $i (@input) {
    my $depth = make_tree($i);
    say <<"END";
    Input:  '$i'
    Output: $depth
END
}

sub make_tree( $input ) {
    my @rows;
    my $e = 0;

    my @input = split m{\s*\|\s*}, $input;    # basis for all the rows
    my %nodes =
        map { $_ => Node->new($_) }
        grep { /\d+/ } split m{\D}, $input;    # create all the nodes

    # here's where the tree is made
    for my $r (@input) {
        my $w   = -1 + 2**$e;
        my @i   = split /\s+/, $r;
        my @row = map { $i[$_] || '*' } 0 .. $w;
        push @rows, \@row;
        for my $n ( 0 .. $w ) {
            my $val  = $row[$n];
            my $node = $nodes{$val};
            my $lr   = $n % 2;
            my $p    = ' ';
            my $u    = ' ';
            if ( $e > 0 ) { $u = int( $n / 2 ); $p = $rows[ $e - 1 ][$u]; }
            my $parent = $nodes{$p};
            if ( defined $node && defined $parent ) {
                my $v = $node->value;
                if   ($lr) { $nodes{$p}->left( $nodes{$v} ); }
                else       { $nodes{$p}->right( $nodes{$v} ); }
            }
        }
        $e++;
    }

    my @o =                         # REMEMBER, READ THIS BACK TO FRONT
        sort { $a <=> $b }          # sort low to high
        map  { 1 + node_depth($_) } # 1 + node_depth = number of nodes involved 
        grep { ! $_->is_root }      # each node is not a root
        grep { $_->is_leaf }        # each node is a leaf
        map  { $nodes{$_} }         # turn it into nodes
        keys %nodes;                # the keys to the nodes
    return $o[0]; # and we pull the first one, which should be 
}

sub node_depth ( $node ) {
    my $d = 0;
    while ( !$node->is_root ) {
        $d++;
        $node = $node->parent;
    }
    return $d;
}

package Node;

sub new ( $class, $value = 0 ) {
    my $self = {};
    $self->{value}  = $value;
    $self->{left}   = undef;
    $self->{right}  = undef;
    $self->{parent} = undef;
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

sub parent ($self ) {
    return $self->{parent};
}
