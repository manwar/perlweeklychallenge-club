#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-071/

# Comments: https://andrewshitov.com/2020/08/01/raku-challenge-week-71/

unit sub MAIN(Int $N is copy where * > 0 = 3, Int $size where * > 0 = 10);
# Cannot use 'is rw' on optional parameter '$N'.

class Node {
    has $.data;
    has $.next is rw;
}

# Create a random linked list. Note that it generates the list
# from its tail towards the head.
my $head;
$head = Node.new(data => 100.rand.Int, next => $head) for ^$size;

say $head;

# Get the lengths of the list.
my $length = 1;
my $curr = $head;
$length++ while $curr = $curr.next;

# Expect $size == $length :-)
# say $length;

if $N >= $size {
    $head = $head.next;
}
else {
    $N--;            # Input "1" means the element with 0 offset from the end;
    $N = $size - $N; # Count from the end
    $curr = $head;
    my $prev = Nil;
    while --$N {
        $prev = $curr;
        $curr = $curr.next;
    }
    $prev.next = $curr.next;
}

say $head;
