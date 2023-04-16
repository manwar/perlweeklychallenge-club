#!/usr/bin/perl
use strict;
use warnings;

package BinaryTree;

sub new {
    my ( $class, $value, $left, $right ) = @_;
    my $self = {
        value => $value,
        left  => $left,
        right => $right,
    };
    bless $self, $class;
    return $self;
}

sub invert {
    my $self = shift;

    ( $self->{left}, $self->{right} ) = ( $self->{right}, $self->{left} );
    $self->{left}->invert()  if defined $self->{left};
    $self->{right}->invert() if defined $self->{right};
}

sub pretty_print {
    my $self           = shift;
    my $padding        = shift || '';
    my $branch_padding = shift || '';

    if ( defined $self->{right} ) {
        $self->{right}->pretty_print( "$padding ", "$padding|" );
    }

    print $branch_padding;
    print "--" if $branch_padding;
    print $self->{value}, "\n";

    if ( defined $self->{left} ) {
        $self->{left}->pretty_print( "$padding ", "$padding|" );
    }
}

package main;

my $tree = BinaryTree->new(
    1,
    BinaryTree->new( 2, BinaryTree->new(4), BinaryTree->new(5) ),
    BinaryTree->new( 3, BinaryTree->new(6), BinaryTree->new(7) )
);

print "Original tree:\n";
$tree->pretty_print();

$tree->invert();

print "\nInverted tree:\n";
$tree->pretty_print();
