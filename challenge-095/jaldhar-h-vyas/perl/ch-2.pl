#!/usr/bin/perl

=head1 NAME

Data::Stack - A Stack Demo

=cut

package Data::Stack;
use Moo;
use List::Util;
use namespace::clean;

=head1 VERSION

Version 0.1

=cut

our $VERSION = '0.1';

=head1 SYNOPSIS

    my $stack = Data::Stack->new;
    $stack->push(2);
    $stack->push(-1);
    $stack->push(0);
    $stack->pop;         # removes 0
    say $stack->top();   # prints -1
    $stack->push(0);
    say $stack->min();   # prints -1

=head1 DESCRIPTION

This is a simple implementation of a stack.  A stack is a data structure where
the items are added and removed in Last In First Out (LIFO) order.

=cut

has _stack => (
    is => 'rw',
    default => sub { [] }
);

=head2 METHODS

=head3 push($value)

    Adds C<$value> onto the top of the stack.

=cut

sub push {
    my ($self, $value) = @_;

    return push @{$self->_stack}, $value;
}

=head3 pop()

    removes the value on top of the stack.

=cut

sub pop {
    my ($self) = @_;

    return pop @{$self->_stack};
}

=head3 top()

    returns the top element in the stack without removing it.

=cut

sub top {
    my ($self) = @_;

    return $self->_stack->[-1];
}

=head3 min()

    returns the minimum element in the stack.

=cut

sub min {
    my ($self) = @_;

    return List::Util::min( @{$self->_stack} );
}

=head1 DEPENDENCIES

L<List::Util>, L<Moo>

=head1 BUGS

None yet.

=head1 AUTHOR

Jaldhar H. Vyas, C<< <jaldhar at braincells.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2021, Consolidated Braincells Inc.

"Do what thou wilt" shall be the whole of the license.

=cut

1;
