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

    has Node $!head;
    has Int $.count is readonly;


    submethod BUILD() {
        $!head = Nil;
        $!count = 0;
    }

    method add($newval) {
        my $v = $!head;

        if ($v) {
            while $v.next {
                $v = $v.next;
            }
            $v.next = Node.new(value => $newval);
        } else {
            $!head = Node.new(value => $newval);
        }

        $!count++;
    }

    method print() {
        my $v = $!head;

        while $v {
            print $v.value // q{}, q{ };
            $v = $v.next;
        }

        print "\n";
    }

    method trim(Int $n) {
        my $i = $n > $.count ?? 0 !! $.count - $n;

        if ($!head && $i == 0) {
            my $temp = $!head;
            $!head = $!head.next;
            $temp = Nil;
        } else {
            my $v = $!head;
            my $c = 0;
 
            while $v {
                $c++;
                if $c == $i {
                    if $v.next {
                        $v.next = $v.next.next;
                    } else {
                        $v = Nil;
                    }
                    last;
                }
                $v = $v.next;
            }
        }
    }
}

multi sub MAIN(
    Int $N  #= > 0
    where { $N > 0 }
) {
    my $linked_list = LinkedList.new();
    $linked_list.add(1);
    $linked_list.add(2);
    $linked_list.add(3);
    $linked_list.add(4);
    $linked_list.add(5);

    $linked_list.trim($N);

    $linked_list.print();
}