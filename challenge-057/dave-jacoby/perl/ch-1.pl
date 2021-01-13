#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ fc postderef say signatures state switch };
no warnings qw{ experimental };

use List::Util qw{max};
use JSON;

my $json  = JSON->new->pretty->canonical;
my %nodes = import_tree( $ARGV[0] );

my ($rand) = keys %nodes;
my $root = find_root( $nodes{$rand} );

if ( is_binary_tree($root) ) {
    display_tree($root);
    reverse_tree($root);
    display_tree($root);
    export_tree( \%nodes, $ARGV[1] );
}

exit;

sub tree_depth ( $node ) {
    return 0 if $node->is_root();
    return 1 + tree_depth( $node->parent() );
}

sub is_binary_tree ( $node ) {
    state $depth = -1;

    # if all the leaves are at the same depth
    # return 1, else return 0
    if ( $node->is_leaf ) {
        my $d = tree_depth($node);
        $depth = $d if $depth < 0;
        return 0 if $depth != $d;
        return 1;
    }

    # return 0 if we don't have two children
    return 0 unless defined $node->left && defined $node->right;
    return ( is_binary_tree( $node->left ) && is_binary_tree( $node->right ) );
}

sub display_tree ( $node, $depth = 0, $arrayref = [] ) {

    # instead of hash or Node display, we're pulling it
    # to $arrayref->[ depth ][ left .. right ]
    if ($node) {
        push $arrayref->[$depth]->@*, $node->value();
        display_tree( $node->left(),  $depth + 1, $arrayref );
        display_tree( $node->right(), $depth + 1, $arrayref );
    }
    else {
        push $arrayref->[$depth]->@*, '_';
    }

    # when we've recursed and returned to the root
    if ( $depth == 0 ) {
        my $max   = $arrayref->@*;
        my $w     = 4 + ( 2**$max );
        my $edges = q{/  \\};
        for my $i ( 0 .. -1 + scalar $arrayref->@* ) {
            my $l = $arrayref->[$i];
            next unless scalar grep { $_ ne '_' } $l->@*;
            if ( $i > 0 ) {
                my $l    = $arrayref->[ $i - 1 ];
                my $str2 = join '    ', map { $edges } $l->@*;
                my $pad2 = ' ' x ( $w - int( 0.5 * length $str2 ) );
                say qq{$pad2$str2};
            }
            my $str = join '    ', $l->@*;
            my $pad = ' ' x ( $w - int( 0.5 * length $str ) );
            say qq{$pad$str};
        }
    }
}

sub reverse_tree( $node ) {
    if ( defined $node->left() && defined $node->right() ) {
        my $store = $node->left();
        $node->left( $node->right() );
        $node->right($store);
    }
    elsif ( defined $node->left() ) {
        $node->right( $node->left() );
        $node->{left} = undef;
    }
    elsif ( defined $node->right() ) {
        $node->left( $node->right() );
        $node->{right} = undef;
    }
    reverse_tree( $node->left() )  if $node->left();
    reverse_tree( $node->right() ) if $node->right();
}

sub find_root( $node ) {
    return $node if ( $node->is_root );
    return find_root( $node->parent() );
}

sub import_tree ( $file = "" ) {
    if ( -f $file && open my $fh, '<', $file ) {
        my $text  = join '', <$fh>;
        my $obj   = $json->decode($text);
        my %nodes = map { $_ => Node->new($_) } $obj->{nodes}->@*;
        for my $id ( $obj->{nodes}->@* ) {
            my $left  = $obj->{left}{$id};
            my $right = $obj->{right}{$id};
            $nodes{$id}->left( $nodes{$left} )   if defined $left;
            $nodes{$id}->right( $nodes{$right} ) if defined $right;
        }
        return wantarray ? %nodes : \%nodes;
    }
    exit;
}

sub export_tree ( $nodes, $file = undef ) {
    my $obj = {};
    for my $node ( values $nodes->%* ) {
        my $left  = $node->left();
        my $right = $node->right();
        my $id    = $node->value();
        push $obj->{nodes}->@*, $id;
        $obj->{left}{$id}  = $left->value()  if $left;
        $obj->{right}{$id} = $right->value() if $right;
    }
    $obj->{nodes}->@* = sort $obj->{nodes}->@*;
    if ( defined $file && open my $fh, '>', $file ) {
        say $fh $json->encode($obj);
    }
    else {
        say $json->encode($obj);
    }
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

sub value ( $self ) {
    return $self->{value};
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
