#!/usr/bin/perl6

class Data::PriorityQueue {

    class Element {
        has Any $.value is rw;
        has Int $.priority is rw;
    }

    has Element @!queue = ();

    method clear {
        @!queue = ();
    }

    method top() {
        return @!queue[0].value;
    }

    method insert_with_priority(Any $value, Int $priority = 0) {
        my $pos = 0;
        while $pos < @!queue.elems && @!queue[$pos].priority >= $priority {
            $pos++;
        }
        my @remainder = @!queue.splice($pos, @!queue.elems - $pos);
        @!queue.push(
            Element.new(value => $value, priority => $priority),
        ).append(@remainder);
    }

    method is_empty() {
        return @!queue.elems == 0;
    }

    method pull_highest_priority_element() {
        if !self.is_empty {
            return @!queue.shift.value;
        }
        return Nil;
    }

    method size() {
        return @!queue.elems;
    }

}

# some random operations
   my $q = Data::PriorityQueue.new;

    $q.insert_with_priority('one', 1);

    say $q.pull_highest_priority_element(); # will print 'one'

    say $q.is_empty ?? 'YES' !! 'No';  # will print 'YES'

    $q.insert_with_priority('two', 2);
    $q.insert_with_priority('one', 3);
    $q.insert_with_priority('three', 3);
    $q.insert_with_priority('one', 1);

    say $q.pull_highest_priority_element(); # will print 'one'

    $q.clear;
