#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

# 1) make the triangle
# 2) traverse the triangle

use Carp;
use Getopt::Long;

my $n = 2;
GetOptions( 'number=i' => \$n );
croak 'Too Small' if $n < 0;

my $tree  = make_triangle($n);
my $start = $tree->[0][0];
my $end   = $start;
while ( $end->right ) {
    $end = $end->right;
}
traverse_tree( $start, $end );

my @output;

sub traverse_tree ( $node, $end, $path = '' ) {
    return unless $node;
    my $value = $node->value;
    my $ev    = $end->value();
    if ( $value eq $ev ) {
        push @output, $path;
    }
    my $l = $node->left;
    my $r = $node->right;
    my $h = $node->horizontal;
    my $flag =
           defined $l
        || defined $r
        || defined $h ? 1 : 0;
    traverse_tree( $h, $end, $path . 'H' ) if defined $h;
    traverse_tree( $l, $end, $path . 'L' ) if defined $l;
    traverse_tree( $r, $end, $path . 'R' ) if defined $r;
}

say join " ", sort { length $a <=> length $b } @output;

exit;

sub test_tree( $tree ) {
    say 'VALUE';
    for my $i ( 0 .. -1 + scalar $tree->@* ) {
        say join ' ', map { $_->value } $tree->[$i]->@*;
    }
    say 'LEFT';
    for my $i ( 0 .. -1 + scalar $tree->@* ) {
        say join ' ',
            map { defined $_->left ? $_->left->value : 'LLL' }
            $tree->[$i]->@*;
    }
    say 'RIGHT';
    for my $i ( 0 .. -1 + scalar $tree->@* ) {
        say join ' ',
            map { defined $_->right ? $_->right->value : 'RRR' }
            $tree->[$i]->@*;
    }
    say 'HORIZONTAL';
    for my $i ( 0 .. -1 + scalar $tree->@* ) {
        say join ' ',
            map { defined $_->horizontal ? $_->horizontal->value : 'HHH' }
            $tree->[$i]->@*;
    }
}

sub make_triangle( $n ) {
    my @rows;

    my $tree;
    for my $i ( 0 .. $n ) {
        for my $j ( 0 .. $i ) {
            my $k = 2 * ( int( $j / 2 ) );
            push $tree->[$i]->@*, Node->new(1);
        }
    }
    for my $i ( 0 .. $n ) {
        for my $j ( 0 .. -1 + scalar $tree->[$i]->@* ) {
            $tree->[$i][$j]->value( join ',', $i, $j );
        }
    }

    for my $i ( 0 .. $n ) {
        for my $j ( 0 .. -1 + scalar $tree->[$i]->@* ) {
            if ( defined $tree->[ $i + 1 ][$j] ) {
                $tree->[$i][$j]->left( $tree->[ $i + 1 ][$j] );
            }
            if ( defined $tree->[ $i + 1 ][ $j + 1 ] ) {
                $tree->[$i][$j]->right( $tree->[ $i + 1 ][ $j + 1 ] );
            }
            if ( $j < $i ) {
                $tree->[$i][$j]->horizontal( $tree->[$i][ $j + 1 ] );
            }
        }
    }
    return $tree;
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
