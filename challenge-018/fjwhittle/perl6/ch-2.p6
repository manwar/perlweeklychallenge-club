#!/usr/bin/env perl6

class Priority-Queue {
  has Array %queue{UInt};

  method is_empty {
    not %queue.values.grep(*.elems);
  }

  method insert_with_priority($element, UInt $prio = 0) {
    %queue.push: $prio => $element;
  }

  method pull_highest_priority_element {
    %queue.pairs.grep(*.value.elems).sort(- *.key).first.value.shift;
  }
}

use Test;

plan 7;

my $q = Priority-Queue.new;

is $q.is_empty, True, 'New queue is empty';

$q.insert_with_priority('foo');
$q.insert_with_priority('baz', 1);
$q.insert_with_priority('bar', 0);

is $q.is_empty, False, 'Added three elements, queue is not empty';

is $q.pull_highest_priority_element, 'baz', 'Pulled baz, second added with priority 1 first';

is $q.is_empty, False, 'Queue is still not empty';

is $q.pull_highest_priority_element, 'foo', 'Pulled foo, first added with priority 0 second';

is $q.pull_highest_priority_element, 'bar', 'Pulled bar, last added with priority 0 third';

is $q.is_empty, True, 'Queue is empty after all elements pulled';

