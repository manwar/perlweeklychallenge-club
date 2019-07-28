# Write a script to implement Priority Queue. It is like regular queue except
# each element has a priority associated with it. In a priority queue, an
# element with high priority is served before an element with low priority.
# Please check this wiki page for more informations. It should serve the
# following operations:
#
#   1) is_empty: check whether the queue has no elements.
#   2) insert_with_priority: add an element to the queue with an associated
#      priority.
#   3) pull_highest_priority_element: remove the element from the queue that
#      has the highest priority, and return it. If two elements have the same
#      priority, then return element added first.


class PriorityQueue {
    # The last element in the queue is always the element with the highest
    # priority.
    has @queue = [];

    method is_empty {
        return @queue.elems == 0;
    }

    method insert_with_priority($elm, $priority) {
        # Find the priority index for the element in the queue. If no index
        # can be found, the element has the lowest priority in the queue.
        my @idx = @queue.grep(-> ($i, $j) { $i >= $priority }, :k);
        if (@idx.elems == 0) {
            @queue.push([$priority, $elm]);
        } else {
            my $i = @idx[0];
            @queue = [|(@queue[^$i]), [$priority, $elm], |(@queue[$i..*-1])];
        }
    }

    submethod pull_highest_priority_element() {
        return @queue.pop()[1];
    }
}


multi MAIN('test') {
    use Test;

    my $pqueue = PriorityQueue.new();
    is $pqueue.is_empty(), True;

    $pqueue.insert_with_priority(1, 1);
    $pqueue.insert_with_priority(2, 2);
    $pqueue.insert_with_priority(3, 2);
    $pqueue.insert_with_priority(4, 1);
    $pqueue.insert_with_priority(5, 0);
    $pqueue.insert_with_priority(6, 2);
    $pqueue.insert_with_priority(7, 0);

    is $pqueue.is_empty(), False;
    is $pqueue.pull_highest_priority_element(), 2;
    is $pqueue.pull_highest_priority_element(), 3;
    is $pqueue.pull_highest_priority_element(), 6;
    is $pqueue.pull_highest_priority_element(), 1;
    is $pqueue.pull_highest_priority_element(), 4;
    is $pqueue.pull_highest_priority_element(), 5;
    is $pqueue.pull_highest_priority_element(), 7;
    is $pqueue.is_empty(), True;
}
