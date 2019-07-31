#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-018/
# Task #2
# Write a script to implement Priority Queue. It is like regular queue except
# each element has a priority associated with it.
# In a priority queue, an element with high priority is served before an element
# with low priority. Please check this wiki page for more informations.
# https://en.wikipedia.org/wiki/Priority_queue
#
# It should serve the following operations:
# 1) is_empty: check whether the queue has no elements.
# 2) insert_with_priority: add an element to the queue with an associated priority.
# 3) pull_highest_priority_element: remove the element from the queue that has
#     the highest priority, and return it. If two elements have the same priority,
#     then return element added first.
#

use strict;
use warnings;

my $queue = {};

print "Add elements to the queue: ELEMENT,PRIORITY\n";
print "(priority 1 is the highest, 9 is the lowest)\n";
while (<STDIN>) {
    chomp;
    my ($element, $priority) = split ',';
    last unless (defined $priority && $priority =~ /^[1-9]$/);
    insert_with_priority($queue, $element, $priority);
    print ".Added: $element => $priority\n";
}

print "Processing queue by priority ...\n";
print ".Serving: $_\n" while (local $_ = pull_highest_priority_element($queue));
print "Queue is empty\n";

sub is_empty {
    my ($queue) = @_;
    return (keys %$queue ? 0 : 1);
}

sub insert_with_priority {
    my ($queue, $element, $priority) = @_;
    push @{ $queue->{$priority} }, $element;
    return;
}

sub pull_highest_priority_element {
    my ($queue) = @_;
    return if is_empty($queue);

    my ($k) = sort keys %$queue; # highest priority key
    my $e = shift @{ $queue->{$k} }; # first element of the highest priority

    # if there are no more elements, remove priority key from the queue
    delete $queue->{$k} unless @{ $queue->{$k} };

    return $e;
}
