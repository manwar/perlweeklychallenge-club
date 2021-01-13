# You are given a singly linked list $L as below:
#
# L0 →  L1 →  … →  Ln-1 →  Ln
#
# Write a script to reorder list as below:
#
# L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 →
#
# You are ONLY allowed to do this in-place without altering the nodes’ values.
# Example
#
# Input:  1 →  2 →  3 →  4
# Output: 1 →  4 →  2 →  3
#

class Node {
    has Int $.value is rw;
    has Node $.next is rw;
}

class LinkedList {
    has Node $.head is rw;

    method create-list(@values) {
        my $cur-node = $!head;

        for @values -> $v {
            my $new-node = Node.new(value => $v);
            if ($cur-node) {
                $cur-node.next = $new-node;
            } else {
                $!head = $new-node;
            }
            $cur-node = $new-node;
        }
    }

    method print-list() {
        my $cur-node = $!head;
        my @values = [];
        while ($cur-node) {
            @values.push($cur-node.value);
            $cur-node = $cur-node.next;
        }
        say @values.join(' -> ');
    }

    method reorder-list() {
        my $cur-node = $!head;
        while ($cur-node.next and $cur-node.next.next) {
            my $one-but-last-node = $cur-node;
            my $last-node = $cur-node.next;

            while ($last-node.next) {
                $one-but-last-node = $last-node;
                $last-node = $last-node.next;
            }

            $last-node.next = $cur-node.next;
            $cur-node.next = $last-node;
            $one-but-last-node.next = Nil;
            $cur-node = $last-node.next;
        }
    }
}

my $linked-list = LinkedList.new();
$linked-list.create-list([1, 2, 3, 4, 5, 6, 7, 8]);
$linked-list.print-list();
$linked-list.reorder-list();
$linked-list.print-list();
