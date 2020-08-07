#!/usr/bin/env perl6
#
#
#       basket-weaving.raku
#
#       TASK #2 › Reorder List
#             Submitted by: Mohammad S Anwar
#             You are given a singly linked list $L as below:
#
#                 L0 →  L1 →  … →  Ln-1 →  Ln
#             Write a script to reorder list as below:
#
#                 L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 →
#             You are ONLY allowed to do this in-place without altering
#             the nodes’ values.
#
#             Example
#                 Input:  1 →  2 →  3 →  4
#                 Output: 1 →  4 →  2 →  3
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

class Node {
    has Any  $.value is rw;
    has Node $.next  is rw;
}

class LinkedList {
    has Node $.first is rw;
    has Node $!last;

    ## custom accessor for list.last
    ## sets up a trigger on write to set node.next to Nil
    method last( Node $node? ) is rw {
        Proxy.new:
            FETCH => sub ($)         { $!last },
            STORE => sub ($, $node)  { $!last = $node;
                                       $node.next = Nil },
    }

    method populate_from_array ( @array ) {
        my $node;
        my $next;
        while @array.elems > 0 {
            $node = Node.new(value => @array.pop);
            $!last //= $node;
            $node.next = $next if $next.defined;
            $next = $node;
        }
        $.first = $node;
    }

    method arrow_print () {
        my @output;
        my $node = $.first;
        loop {
            @output.push: $node.value;
            last if $node === $!last;
            $node = $node.next;
        }
        @output.join(' → ').say;
    }
}

multi MAIN () {
    say "Usage: ./basket-weaving.raku value1 value2 value3 ...";
}

multi MAIN ( *@input ) {

    ## convert the input commandline array into a linked list
    my $list = LinkedList.new();
    $list.populate_from_array( @input );
    $list.arrow_print();

    ## the moved node inserts after the splice point
    ## $node is a working container
    my $splicepoint = my $node = $list.first;

    while $splicepoint !=== $list.last {

        ## when the splice point is second to last before the splice,
        ## last node is to be spliced into the same location
        ## we are done so jump out
        ## This happens only when the node count is even.
        last if $splicepoint.next === $list.last;

        ## temporarily go to the 2nd to last node
        $node = $node.next while $node.next !=== $list.last;

        ## relink the last node:
        ##   set the last node .next to the splice point .next
        ##   update the splice point .next to the last node
        ##   update the last node to the working node
        $list.last.next   = $splicepoint.next;
        $splicepoint.next = $list.last;
        $list.last        = $node;

        ## reset the splice point and working node to
        ## jump forward 2 nodes and splice again
        $node = $splicepoint = $splicepoint.next.next;

        $list.arrow_print();

    }
}
