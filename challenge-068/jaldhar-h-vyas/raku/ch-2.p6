#!/usr/bin/perl6

class Node {
    has $.value is rw;
    has Node $.next is rw;

    multi submethod BUILD( :$value) {
        $!value = $value;
        $!next = Nil;
    }

    method add($newval) {
        my $v = self;

        while $v.next {
            $v = $v.next;
        }

        $v.next = Node.new(value => $newval);
    }

    method print() {

        my $v = self;

        while $v.next {
            print $v.value // q{}, q{ };
            $v = $v.next;
        }

        print $v.value, "\n";
    }

    method reorder() {

        my $current = self;

        while $current {
            my $last = $current;
            my $second = $current;
            while $last.next {
                $second = $last;
                $last = $last.next;
            }

            $second.next = Nil;
            $last.next = $current.next;
            $current.next = $last;

            if $current.next {
                $current = $current.next.next;
            } else {
                $current = $current.next;
            }
        }
    }
}

multi sub MAIN() {
    my $linked_list = Node.new(value => 1);
    $linked_list.add(2);
    $linked_list.add(3);
    $linked_list.add(4);

    $linked_list.reorder();
    $linked_list.print();
}