#!/usr/bin/env perl6

=begin DESC

Write a script to implement Priority Queue. It is like regular queue except each element 
has a priority associated with it. In a priority queue, an element with high priority is
served before an element with low priority. It should serve the following operations:

=item 1) is_empty
    check whether the queue has no elements.
=item 2) insert_with_priority
    add an element to the queue with an associated priority.
=item 3) pull_highest_priority_element
    remove the element from the queue that has the highest priority, and return it. 
    If two elements have the same priority, then return element added first.

=end DESC

class ÜberNaïvePriorityQueue {
    has @!elements;

    method is-empty() {
        return @!elements.elems == 0;
    }

    method insert-with-priority( $value, $priority ) {
        @!elements.push( %( :$value, :$priority ) );
    }

    method pull-highest-priority-element() {
        return if self.is-empty;

        # Find the first highest priority element.
        my $max-pair = @!elements.map( { .<priority> } ).maxpairs.first;

        # Remove and return the first element with the highest priority.
        return @!elements.splice( $max-pair.key, 1 ).first.<value>;
    }
}


use Test;

my $q = ÜberNaïvePriorityQueue.new;
ok $q.is-empty, 'q is empty';

my @cases = 
    # ( value, priority )
    ( 'a', 17 ),
    ( 'x', 33 ),
    ( 'y', -1 ),
    ( 'b', 17 ),
;
for @cases -> $case {
    $q.insert-with-priority( |@$case );
}

nok $q.is-empty, 'q is not empty';
is $q.pull-highest-priority-element, 'x', 'x is highest';
is $q.pull-highest-priority-element, 'a', 'a is next highest';
is $q.pull-highest-priority-element, 'b', 'b is same priority, but second';
is $q.pull-highest-priority-element, 'y', 'y is lowest';
ok $q.is-empty, 'q is empty';

exit 0;


