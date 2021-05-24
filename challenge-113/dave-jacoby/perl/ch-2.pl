#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

# make the
my %hash = map { $_ => Node->new($_) } 1 .. 7;
$hash{1}->left( $hash{2} );
$hash{1}->right( $hash{3} );
$hash{2}->left( $hash{4} );
$hash{3}->left( $hash{5} );
$hash{3}->right( $hash{6} );
$hash{4}->right( $hash{7} );

# we know the root of the
my $sum = get_sum( $hash{1} );
change_node_value( $hash{1}, $sum );
say $sum;

say qq{Too tired to display this in a clever way\n};

say '                    ' . $hash{1}->value;
say '                   /  \\';
say '                  ' . $hash{2}->value . '   ' . $hash{3}->value;
say '                 /    /  \\';
say '                '
    . $hash{4}->value . '   '
    . $hash{5}->value . '   '
    . $hash{6}->value;
say '                 \\ ';
say '                  ' . $hash{7}->value;
say '';

exit;

# we COULD just go through the whole hash
# table, but that wouldn't be treeish
sub change_node_value ( $node, $sum ) {
    my $v = $node->value;
    my $x = $sum - $v;
    $node->{value} = $x;
    if ( defined $node->left ) {
        change_node_value( $node->left, $sum );
    }
    if ( defined $node->right ) {
        change_node_value( $node->right, $sum );
    }
}

# we COULD just go through the whole hash
# table, but that wouldn't be treeish
sub get_sum( $node ) {
    my $sum = 0;
    $sum += $node->value;
    if ( defined $node->left ) {
        my $val = get_sum( $node->left );
        $sum += $val;
    }
    if ( defined $node->right ) {
        my $val = get_sum( $node->right );
        $sum += $val;
    }
    return $sum;
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
