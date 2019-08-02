#!/usr/bin/perl

=head1 NAME

Data::PriorityQueue - A Priority Queue

=cut

package Data::PriorityQueue;
use Moo;
use namespace::clean;

=head1 VERSION

Version 0.1

=cut

our $VERSION = '0.1';

=head1 SYNOPSIS

    my $q = Data::PriorityQueue->new();

    $q->insert_with_priority('one', 1);

    say $q->pull_highest_priority_element(); # will print 'one'

    say $q->is_empty ? 'YES' : 'No';  # will print 'YES'

    $q->insert_with_priority('two', 2);
    $q->insert_with_priority('one', 3);
    $q->insert_with_priority('three', 3);
    $q->insert_with_priority('one', 1);

    say $q->pull_highest_priority_element(); # will print 'one'

    $q->clear;

=head1 DESCRIPTION

This is a simple implementation of a Priority Queue.  A priority queue is a
data structure where the items are sorted in order of numeric priority.

=cut

has _iterator => (
    is => 'rw',
    default => 0,
);

has _queue => (
    is => 'rw',
    default => sub { [] } # should use a binary heap really but its all good...
);

has _size => (
    is => 'rw',
    default => 0, 
);

=head2 METHODS

=head3 clear()

    removes all elements from the priority queue and resets iteration.

=cut

sub clear {
    my ($self) = @_;

    $self->_queue([]);
    $self->_size(0);
    $self->_iterator(0);
}

=head3 top()

    returns the highest priority element in the queue without removing it.

=cut

sub top {
    my ($self) = @_;

    return $self->_queue->[0]->{value};
}

=head3 insert_with_priority($value, $priority)

    Stores scalar C<$value> in the queue with numeric priority C<$priority>.

=cut

sub insert_with_priority {
    my ($self, $value, $priority) = @_;
    $priority //= 0;

    my $pos = 0;
    while (defined $self->_queue->[$pos] &&
    $self->_queue->[$pos]->{priority} >= $priority) {
        $pos++;
    }
    push @{ $self->_queue }, { value => $value, priority => $priority},
        splice @{ $self->_queue }, $pos, $self->_size - $pos;
    $self->_size($self->_size + 1);
}

=head3 is_empty()

    returns a true value if there are no elements in the priority queue or 
    false otherwise.

=cut

sub is_empty {
    my ($self) = @_;

    return $self->_size == 0;
}

=head3 pull_highest_priority_element()

    Removes the highest priority element from the queue and returns it or C<undef>
    if the queue is empty.  In the event of two elements having the same
    priority, returns the one added first.

=cut

sub pull_highest_priority_element {
    my ($self) = @_;

    if ($self->_size) {
        my $element = shift @{ $self->_queue };
        $self->_size($self->_size - 1);
        return $element->{value};
    }
}


=head3 size()

    returns the number of elements in the queue.

=cut

sub size {
    my ($self) = @_;

    return $self->_size;
}

=head1 AUTHOR

Jaldhar H. Vyas, C<< <jaldhar at braincells.com> >>

=head1 BUGS

For better efficiency the underlying data store should be a binary heap not
an array.

There should be a way to provide a custom comparison function in case you want
something other than numeric priority.

=head1 LICENSE AND COPYRIGHT

Copyright 2019,  Consolidated Braincells Inc.

"Do what thou wilt" shall be the whole of the license.

=cut

1;
