#!/usr/bin/env perl6

role SingleQueue {
    has @!items;

    method add-item( $item ) {
        @!items.push( $item );
    }

    method get-item() {
        return @!items.shift;
    }

    method is-empty() {
        @!items.elems == 0;
    }
}

role OrderedQueue does Iterator does Iterable {

    has SingleQueue %!queues;

    method is_empty() {
        self.is-empty();
    }

    method is-empty() {
        [&&] %!queues.kv.map( -> $k, $v { $v.is-empty } );
    }

    method insert_with_priority( $item, Int() $priority ) {
        self.insert-with-priority( $item, $priority );
    }

    method insert-with-priority( $item, Int() $priority ) {
        %!queues{$priority} //= SingleQueue.new();
        %!queues{$priority}.add-item( $item );
    }

    method pull_highest_priority_element() {
        self.pull-highest-priority-element()
    }

    method pull-highest-priority-element() {
        return Nil if self.is-empty;
        my $queue = %!queues.keys.sort( {$^b <=> $^a }).first;
        my $value = %!queues{$queue}.get-item;
        if %!queues{$queue}.is-empty {
            %!queues{$queue}:delete;
        }
        return $value;
    }

    method pull-one() {
        self.pull-highest-priority-element // IterationEnd;
    }

    method iterator() {
        return self;
    }
}

#| Given a file in csv format "priority,item" add all the items to the queue
#| then print them in the given order
sub MAIN( $file ) {
    my $queue := OrderedQueue.new();

    for $file.IO.lines -> $line {
        my ( $priority, $item ) = $line.split(",");
        $queue.insert-with-priority( $item, $priority );
    }

    .say for $queue;
}