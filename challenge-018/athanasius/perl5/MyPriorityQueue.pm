#!perl

################################################################################
=comment

Perl Weekly Challenge 018
=========================

Task #2
-------
Write a script to implement *Priority Queue*. It is like regular *queue* except
each element has a *priority* associated with it. In a priority queue, an
element with high priority is served before an element with low priority. Please
check this [ https://en.wikipedia.org/wiki/Priority_queue |wiki page] for more
informations. It should serve the following operations:

  1) *is_empty*: check whether the queue has no elements.

  2) *insert_with_priority*: add an element to the queue with an associated
      priority.

  3) *pull_highest_priority_element*: remove the element from the queue that has
      the highest priority, and return it. If two elements have the same
      priority, then return element added first.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

package MyPriorityQueue;

use strict;
use warnings;
use List::Priority;

sub new
{
    my ($class, $reverse) = @_;

    my $self =
       {
           implementation   => List::Priority->new,
           reverse_priority => $reverse // 0,
       };

    return bless $self, $class;
}

sub is_empty
{
    my ($self) = @_;

    return $self->{implementation}->size == 0;
}

sub insert_with_priority
{
    my ($self, $priority, $scalar) = @_;

    my  $result = $self->{implementation}->insert($priority, $scalar);

    $result eq '1' or die $result;
}

sub pull_highest_priority_element
{
    my ($self) = @_;

    # If the queue is empty, undef will be returned

    return $self->{reverse_priority} ? $self->{implementation}->shift :
                                       $self->{implementation}->pop;
}

################################################################################
1;
################################################################################
