#!/usr/bin/perl
use strict;
use 5.40.1;
use warnings;

package ListNode;
use Moo;
use namespace::autoclean;

has value => (
    is       => 'rw',
);

has next => (
    is  => 'rw',
    isa => sub { return ref eq __PACKAGE__ },
);

around BUILDARGS => sub ($orig, $class, @args) {
    return { value => $args[0], next => undef };
};

package LinkedList;
use Moo;
use namespace::autoclean;

has _head => (
    is  => 'rw',
    isa => sub { return ref eq 'ListNode' },
);

has _tail => (
    is  => 'rw',
    isa => sub { return ref eq 'ListNode' },
);

has digits => (
    is      => 'ro',
    default => sub { [] },
);

sub BUILD ($self, $args) {
    for my $digit (@{ $args->{digits} }) {
        $self->append($digit);
    }
}

sub append($self, $value) {
    my $node = ListNode->new($value);

    if (defined $self->_head) {
        $self->_tail->next($node);
    }
    else {
        $self->_head($node);
    }
    $self->_tail($node);

    return $self;
}

sub values($self) {
    my @values;
    my $node = $self->_head;

    while (defined $node) {
        push @values, $node->value;
        $node = $node->next;
    }

    return \@values;
}

sub add($self, $other) {
    my @left   = @{ $self->values };
    my @right  = @{ $other->values };
    my @result;
    my $carry = 0;

    while (@left || @right || $carry) {
        my $sum = (pop(@left) // 0) + (pop(@right) // 0) + $carry;
        $carry = int($sum / 10);
        unshift @result, $sum % 10;
    }

    return LinkedList->new(digits => \@result);
}

sub print($self) {
    say join q{ -> }, @{ $self->values };
}

package main;

sub parseDigits($input) {

    $input =~ s/->/ /g;
    my @digits = grep { length } split /[,\s]+/, $input;

    return \@digits;
}

my ($leftInput, $rightInput) = @ARGV;

my $left  = LinkedList->new(digits => parseDigits($leftInput));
my $right = LinkedList->new(digits => parseDigits($rightInput));
$left->add($right)->print;