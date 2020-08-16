#!/usr/bin/perl6

class LinkedList {

    class Node {
        has $.value is rw;
        has Node $.next is rw;

        submethod BUILD( :$value) {
            $!value = $value;
            $!next = Nil;
        }
    }

    has Node $.head is rw;


    submethod BUILD() {
        self.head = Nil;
    }

    method add($newval) {
        my $v = $.head;

        if $v {
            while $v.next {
                $v = $v.next;
            }
            $v.next = Node.new(value => $newval);
        } else {
            $.head = Node.new(value => $newval);
        }
    }

    method print() {
        my $v = $.head;

        while $v {
            print $v.value // q{}, q{ };
            $v = $v.next;
        }

        print "\n";
    }

    method attach(Node $node) {
        my $v = $.head;

        if $v {
            while $v.next {
                $v = $v.next;
            }
            $v.next = $node;
        } else {
            $.head = $node;
        }
    }

    method merge(LinkedList $n) {
        my $v = $.head;

        if $v {
            while $v.next {
                $v = $v.next;
            }
            $v.next = $n.head;
        } else {
            $.head = $n.head;
        }
    }

    method partition(Int $k) {
        my $higher = LinkedList.new();
        my $lower = LinkedList.new();
        my $same = LinkedList.new();

        my $v = $.head;

        while $v {
            my $node = $v;
            $v = $v.next;
            $node.next = Nil;

            if ($node.value < $k) {
                $lower.attach($node);
            } elsif ($node.value > $k) {
                $higher.attach($node);
            } else {
                $same.attach($node);
            }
        }

        if ($.head) {
            $.head = Nil;
        }

        self.merge($lower);
        self.merge($same);
        self.merge($$higher);
    }
}

sub MAIN() {
    my $linked_list = LinkedList.new();
    $linked_list.add(1);
    $linked_list.add(4);
    $linked_list.add(3);
    $linked_list.add(2);
    $linked_list.add(5);
    $linked_list.add(2);

    $linked_list.partition(3);

    $linked_list.print();
}