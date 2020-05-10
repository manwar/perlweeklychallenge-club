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

class DLLNode {
    has Int $.value is rw;
    has DLLNode $.next is rw;
    has DLLNode $.prev is rw;
    method display {
        return " -> " ~ $.value;
    }
}

class LinkedList {
    has DLLNode $.head is rw;
    has DLLNode $.tail is rw;
    has Int $!items=0;
    
    method is-tail(DLLNode $n) {
        return $n===$.tail;
    }
    
    method is-head(DLLNode $n) {
        return $n===$.head;
    }
    
    method display {
        return "Empty List" if $!items==0;
        my $n = $.head;
        my $s="(Items $!items)|-> " ~ $n.value;
        while not self.is-tail($n) {
            $n=$n.next;
            $s~=$n.display;
        }
        return $s;
    }
    
    method add-to-tail($v) {
        my $n= DLLNode.new(value=>$v);
        $!items++;
        if $!items==1 {
            self.head=$n;
            self.tail=$n;
            return;
        } 
        $n.prev=self.tail;
        $n.prev.next=$n;
        self.tail=$n;
    }

    method add-to-head($v) {
        my $n=DLLNode.new(value=>$v);
        $!items++;
        if $!items==0 {
            self.head=$n;
            self.tail=$n;
            return;
        }
        self.head.prev=$n;
        $n.next=self.head;
        self.head=$n;
    }

    method add-after(DLLNode $n, Int $v) {
        if self.is-tail($n) { self.add-to-tail($v); return };
        my $i = DLLNode.new(value => $v);
        $i.prev=$n;
        $i.next=$n.next;
        $i.next.prev=$i;
        $n.next=$i;
        $!items++;
    }

    method remove-node($n) {
        return if $!items==0;
        $!items--;
        if $!items==0 {
            self.head=Nil;
            self.tail=Nil;
            $n.prev=Nil;
            $n.next=Nil;
            return $n;
        }
        if self.is-head($n) {
            self.head=$n.next;
            self.head.prev=Nil;
            $n.next=Nil;
            return $n;
        }
        if self.is-tail($n) {
            self.tail=$n.prev;
            self.tail.next=Nil;
            $n.prev=Nil;
            return $n;
        }
        $n.prev.next=$n.next;
        $n.next.prev=$n.prev;
        $n.next=Nil;
        $n.prev=Nil;
        return $n;
    }
    
    method partioned-sort(Int $k) {
        # search for k
        # from k onwards
        # skip if >=
        # otherwise search from root, place asap
        my DLLNode $n = self.head;
        loop {
            last if $n.value==$k;
            die "[$k] not found in list" if self.is-tail($n);
            $n=$n.next;
        }
        die "[$k] is end of list already" if self.is-tail($n);

        $n.=next;
        my $next=$n;
        loop {
            $next=$n.next;
            if $n.value <= $k {
                $n = self.remove-node($n);
                my $i=self.head;
                $i.=next while $i.value < $n.value;
                self.add-after($i.prev,$n.value);
            }
            last unless $next.defined;
            $n=$next;
        }
    }
}

my  $ll = LinkedList.new;
is $ll.display,"Empty List","test empty";
$ll.add-to-tail(1);
is $ll.display,"(Items 1)|-> 1","test add to tail";
$ll.add-to-tail(2);
is $ll.display,"(Items 2)|-> 1 -> 2","test add to tail";
$ll.add-to-tail(3);
is $ll.display,"(Items 3)|-> 1 -> 2 -> 3","test add to tail";
$ll.add-to-head(0);
is $ll.display,"(Items 4)|-> 0 -> 1 -> 2 -> 3","test add to head";

my $h = $ll.head;
my $t = $ll.tail;
$ll.remove-node($t);
is $ll.display,"(Items 3)|-> 0 -> 1 -> 2","test tail remove";
$ll.remove-node($h);
is $ll.display,"(Items 2)|-> 1 -> 2","test head remove";

$h = $ll.head;
$t = $ll.tail;
$ll.remove-node($t);
is $ll.display,"(Items 1)|-> 1","test tail remove";
$ll.remove-node($h);
is $ll.display,"Empty List","test head remove";

$ll.add-to-tail(1);
$ll.add-to-tail(4);
$h=$ll.head;
$t=$ll.tail;
$ll.add-after($h,0);
is $ll.display,"(Items 3)|-> 1 -> 0 -> 4","test add after";
$ll.add-after($t,0);
is $ll.display,"(Items 4)|-> 1 -> 0 -> 4 -> 0","test add after";
$ll.remove-node($ll.tail);
$ll.remove-node($ll.tail);
$ll.remove-node($ll.tail);
$ll.remove-node($ll.tail);

$ll.add-to-tail($_) for 1, 4, 3, 2, 5, 2;
is $ll.display,"(Items 6)|-> 1 -> 4 -> 3 -> 2 -> 5 -> 2","before partitioned sort";

diag "partitioning by k=3";
$ll.partioned-sort(3);
is $ll.display,"(Items 6)|-> 1 -> 2 -> 2 -> 4 -> 3 -> 5","after partitioned sort";

done-testing;
