#!/bin/env perl6

class task {
    has UInt $.priority;
    has Str  $.id;
}

class PriorityQueue {
    has UInt @!priorities;      # keep sorted
    has      %!queue{ UInt };   # UInt => task array

    submethod BUILD() {
        @!priorities = ();
        %!queue      = %();
    }

    method is_empty(--> Bool) { %!queue.elems == 0 }

    method add-new-task(UInt:D $priority, task:D $task) {
        my UInt $start = 0;
        my UInt $end   = max(0, @!priorities.elems - 1);

        while ($end - $start > 1) {
            my UInt $index = ($start + $end) / 2;

            if $priority < @!priorities[$index] {
                $start = $index;
            } elsif $priority > @!priorities[$index] {
                $end = $index;
            } else { # $priority == @!priorities[$index]
                %!queue{ $priority }.push($task);
            }
        }

        put("end - start should be 0 or 1: { $end - $start }");
        @!priorities.splice($start, 0, [$priority]);
        %!queue{ $priority } = [$task];
    }

    method insert-with-priority(UInt:D $priority, Str:D $task-id) {
        my $new-task = task.new(priority => $priority, id => $task-id);
        self.add-new-task($priority, $new-task);
    }

    method pull-highest-priority-element() {
        return Nil if %!queue.elems == 0;

        my $t = %!queue{ @!priorities[0] }.pop;
        if %!queue{ @!priorities[0] }.elems == 0 {
            %!queue{ @!priorities[0] }:delete;
            @!priorities.pop;
        }
        return $t;
    }

    method elems { [@!priorities.elems, %!queue.elems] }
}

use Test;
plan 5;

my PriorityQueue $que = PriorityQueue.new;

is True, $que.is_empty, 'default queue is empty';

$que.insert-with-priority(3, 'task one');
is [1, 1], $que.elems, 'task queue length is 1 after 1 insertion';

my $t = $que.pull-highest-priority-element;
is 3, $t.priority, 'task priority is 3';
is 'task one', $t.id, 'task is correct';

is [0, 0], $que.elems, 'task queue length is 0 after element is pulled';
