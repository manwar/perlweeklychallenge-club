#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

# separate blocks so I can copy and paste a bit more
# without the compiler barking at me
{
    my %hash = map { $_ => Node->new($_) } 1 .. 4;
    $hash{1}->left( $hash{2} );
    $hash{2}->left( $hash{3} );
    $hash{2}->right( $hash{4} );
    say 'EXAMPLE 1';
    my @headers = qw{ sum value leaf };
    say join "\t", '', @headers;
    say join "\t", '', map { '=' x length $_ } @headers;
    my $output = sum_paths( $hash{1} );
    say qq{OUTPUT: $output};
    say '';
}

{
    my %hash = map { $_ => Node->new($_) } 1 .. 6;
    $hash{1}->left( $hash{2} );
    $hash{2}->left( $hash{4} );
    $hash{1}->right( $hash{3} );
    $hash{3}->left( $hash{5} );
    $hash{3}->right( $hash{6} );
    say 'EXAMPLE 2';
    my @headers = qw{ sum value leaf };
    say join "\t", '', @headers;
    say join "\t", '', map { '=' x length $_ } @headers;
    my $output = sum_paths( $hash{1} );
    say qq{OUTPUT: $output};
    say '';
}

exit;

sub sum_paths ( $node ) {

    # initial setup
    my $left  = $node->left;
    my $right = $node->right;

    # is leaf
    if ( !defined $left && !defined $right ) {

        # we sum back to the root by copying the
        # node (so we don't get lost), adding the
        # value to the sum, and going a level to
        # the root
        my $n   = $node;
        my $sum = $n->value;
        while ( !$n->is_root ) {
            $n = $n->parent;
            $sum += $n->value;
        }
        say join "\t", '', $node->value, $sum, $node->is_leaf;
        return $sum;
    }

    # then we go left, go right and return the sum we have
    my $sum = 0;
    $sum += sum_paths($left)  if defined $left;
    $sum += sum_paths($right) if defined $right;
    say join "\t", '', $node->value, $sum, $node->is_leaf;
    return $sum;
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
