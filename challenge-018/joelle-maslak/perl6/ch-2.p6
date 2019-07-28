#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

class Priority-Queue {
    has %!priorities;
    has $!max;

    method is_empty() { return ! %!priorities.keys.elems }

    method insert_with_priority($element, $priority) {
        %!priorities{$priority} //= [];
        %!priorities{$priority}.push: $element;

        if (! $!max.defined) or ($priority > $!max) {
            $!max = $priority;
        }
    }

    method pull_highest_priority_element() {
        my $elem = %!priorities{$!max}.shift;

        if %!priorities{$!max}.elems == 0 {
            %!priorities{$!max}:delete;
            $!max = %!priorities.keys.max;
        }

        return $elem;
    }
}

sub MAIN() {
    use Test;

    my $pk = Priority-Queue.new;

    subtest 'Start empty', {
        is $pk.is_empty, True;
    }

    subtest 'One element insert', {
        $pk.insert_with_priority('A', 50);
        is $pk.is_empty, False;
        is $pk.pull_highest_priority_element, 'A';
        is $pk.is_empty, True;
    }

    subtest 'With Multiple Priorities', {
        $pk.insert_with_priority('A', 50);
        $pk.insert_with_priority('B', 50);
        $pk.insert_with_priority('C', 75);
        $pk.insert_with_priority('D', 50);
        $pk.insert_with_priority('E', 10);
        $pk.insert_with_priority('F', 10);

        is $pk.is_empty, False;
        is $pk.pull_highest_priority_element, 'C';

        $pk.insert_with_priority('G', 75);
        is $pk.pull_highest_priority_element, 'G';

        is $pk.pull_highest_priority_element, 'A';
        is $pk.pull_highest_priority_element, 'B';
        is $pk.pull_highest_priority_element, 'D';
        is $pk.pull_highest_priority_element, 'E';
        is $pk.pull_highest_priority_element, 'F';

        is $pk.is_empty, True;
    }

    done-testing;
}

