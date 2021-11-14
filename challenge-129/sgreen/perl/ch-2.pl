#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

package LinkedList;

use overload '+' => \&_add, '""' => \&as_string;

sub new {
    my ( $class, @values ) = @_;
    my $self = { _list => [] };
    bless $self, $class;

    # Add any supplied values
    $self->push(@values);

    return $self;
}

sub push {
    my ( $self, @values ) = @_;
    foreach my $value (@values) {
        # Create a new node.
        my $new_node = LinkedList::Node->new($value);

        # Link the last element and the new one
        if ( scalar( @{ $self->{_list} } ) ) {
            my $other_node = $self->{_list}[-1];
            $new_node->set_prev($other_node);
            $other_node->set_next($new_node);
        }

        push @{ $self->{_list} }, $new_node;
    }
}

sub unshift {
    my ( $self, @values ) = @_;
    foreach my $value (@values) {
        # Create a new node.
        my $new_node = LinkedList::Node->new($value);

        # Link the first element and the new one
        if ( scalar( @{ $self->{_list} } ) ) {
            my $other_node = $self->{_list}[0];
            $new_node->set_next($other_node);
            $other_node->set_prev($new_node);
        }

        unshift @{ $self->{_list} }, $new_node;
    }
}

sub first {
    my $self = shift;
    return $self->{_list}[0];
}

sub last {
    my $self = shift;
    return $self->{_list}[-1];
}

sub as_string {
    my $self = shift;
    return join ' -> ', map { $_->value } @{ $self->{_list} };
}

sub _add {
    # Overloaded '+' function, to add two linked lists together
    my ( $first, $second ) = @_;
    my $new_list = LinkedList->new();

    my $first_node  = $first->last;
    my $second_node = $second->last;

    my $carry = 0;

    while ( $first_node or defined $second_node or $carry ) {
        my $sum =
          ( defined $first_node  ? $first_node->value  : 0 ) +
          ( defined $second_node ? $second_node->value : 0 ) +
          $carry;
        $new_list->unshift( $sum % 10 );
        $carry = int( $sum / 10 );

        $first_node  = $first_node->prev  if defined $first_node;
        $second_node = $second_node->prev if defined $second_node;
    }

    return $new_list;
}

package LinkedList::Node;

sub new {
    my ( $class, $value ) = @_;
    my $self = { _value => $value, _last => undef, _prev => undef };
    bless $self, $class;
}

sub value {
    return $_[0]->{_value};
}

sub prev {
    return $_[0]->{_prev};
}

sub next {
    return $_[0]->{_next};
}

sub set_prev {
    $_[0]->{_prev} = $_[1];
}

sub set_next {
    $_[0]->{_next} = $_[1];
}

package main;

sub main {
    # Get all the digits in each value
    my @list1 = ( shift =~ /(\d)/g );
    my @list2 = ( shift =~ /(\d)/g );

    # Turn them into a linked list
    my $list1 = LinkedList->new(@list1);
    my $list2 = LinkedList->new(@list2);

    # ... and display the sum
    my $sum = $list1 + $list2;
    say $sum;
}

main(@ARGV);
