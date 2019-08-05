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

use strict;
use warnings;
use lib qw( . );
use MyPriorityQueue;

MAIN:
{
    print "\n";

    # (1) Larger number = higher priority

    my $pq = MyPriorityQueue->new;
       $pq->insert_with_priority( 4, 'over');
       $pq->insert_with_priority( 8, 'quick');
       $pq->insert_with_priority(12, 'REMOVE');
       $pq->insert_with_priority( 5, 'jumped');
       $pq->insert_with_priority( 0, '--Snoopy');
       $pq->insert_with_priority( 3, 'the');
       $pq->insert_with_priority( 7, 'brown');
       $pq->insert_with_priority( 2, 'unfortunate');
       $pq->insert_with_priority(11, 'The');
       $pq->pull_highest_priority_element;
       $pq->insert_with_priority( 1, 'dog.');
       $pq->insert_with_priority( 7, 'fox');

    extract_and_display($pq);

    # (2) Lower number = higher priority

       $pq = MyPriorityQueue->new(1);
       $pq->insert_with_priority(-1, 'more');
       $pq->insert_with_priority( 2, 'way');
       $pq->insert_with_priority( 6, '--Perl');
       $pq->insert_with_priority( 0, 'than');
       $pq->insert_with_priority( 5, 'it.');
       $pq->insert_with_priority(-2, 'REMOVE');
       $pq->insert_with_priority( 2, 'to');
       $pq->insert_with_priority( 1, 'one');
       $pq->insert_with_priority( 7, 'motto');
       $pq->pull_highest_priority_element;
       $pq->insert_with_priority( 4, 'do');
       $pq->insert_with_priority(-2, "There's");

    extract_and_display($pq);
}

sub extract_and_display
{
    my  ($pq) = @_;
    my   @elements;
    push @elements, $pq->pull_highest_priority_element until $pq->is_empty;

    print join(' ', @elements), "\n";
}

################################################################################
