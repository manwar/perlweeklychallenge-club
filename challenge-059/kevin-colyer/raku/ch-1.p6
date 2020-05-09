#!perl6
# Task 1 Challenge 059 Solution by kevincolyer
use Test;
#TASK #1 › Linked List
#Reviewed by Ryan Thompson
#You are given a linked list and a value k.
# Write a script to partition the linked list such that all nodes less than k
# come before nodes greater than or equal to k.
# Make sure you preserve the original relative order of the nodes in each of the two partitions.
#
#For example:
#
#Linked List: 1 → 4 → 3 → 2 → 5 → 2
#
#k = 3
#
#Expected Output: 1 → 2 → 2 → 4 → 3 → 5.
#



class LinkedList {
    has Int $.value;
    has LinkedList $.next is rw;
    # has LinkedList $.prev is rw;
    method is-tail {
        return $!next.defined ?? False !! True;
    }
    method display {
        my $s = " -> " ~ $!value;
        if self.is-tail { return $s };
        return $s ~ self.next.display;
    }
}

my  $ExampleList = LinkedList.new(value => 1);

is $ExampleList.value, 1, "value is 1";
is $ExampleList.is-tail, True, "At end of list";
$ExampleList.next = LinkedList.new(value => 4);
is $ExampleList.is-tail, False, "Not at end of list";
say $ExampleList.display;

$ExampleList.next.next = LinkedList.new(value => 3);
$ExampleList.next.next.next = LinkedList.new(value => 2);
$ExampleList.next.next.next.next = LinkedList.new(value => 5);
$ExampleList.next.next.next.next.next = LinkedList.new(value => 2);
$ExampleList.next.next.next.next.next.next = LinkedList.new(value => 0);
say $ExampleList.display;

# search for k
# from k onwards
# skip if >=
# otherwise search from root, place asap

my $n = $ExampleList;
my $k=3;
my $kn= $ExampleList;

loop {
    if $n.value==$k {
        $kn=$n;
        last;
    }
    die "[$k] not found in list" if $n.is-tail;
    $n=$n.next;
}
die "[$k] is end of list already" if $kn.is-tail;

my $prev=$n;
$n=$kn.next;
say $n.display;

loop {
    my $next=$n.next;
    say "n value is {$n.value}";
    if $n.value < $k {
        $prev.next=$next; # snip $n out of list
        say $ExampleList.display;
        my $search= $ExampleList; # search from beginning
        my $searchPrev= $ExampleList;
        if $search.value <= $n.value {
            $n.next=$ExampleList;
            $ExampleList=$n;
            $n=$next;
            next;
        } 
        while  $search.value < $n.value {
            say "searching for >={$n.value} got {$search.value}";
            $searchPrev=$search;
            $search=$searchPrev.next;
        }
        say "got {$search.value} inserting before {$searchPrev.value}";
        $searchPrev.next=$n; # reconnect into list
        $n.next=$search;
        say $ExampleList.display;
        # continue loop
        $n=$next;
        last if $prev.is-tail;
        next;
    }
    $prev=$n;
    $n=$next;
    last if $prev.is-tail;
}
say $ExampleList.display;
