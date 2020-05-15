class Node {
    has Int  $.value is rw;
    has Node $.next  is rw;
}

class LinkedList {
    has Node $.first is rw;
    has Node $.last  is rw;

    method populate_from_array ( @array ) {
        my $node;
        my $next;
        while @array.elems > 0 {
            $node = Node.new(value => @array.pop.Int);
            $node.next = $next if $next.defined;
            $next = $node;
        }
        $.first = $node;
    }

    method arrow_print () {
        my @output;
        my $node = $.first;
        while (defined $node) {
            push @output, $node.value;
            $node = $node.next;
        }
        @output.join(' → ').say;
    }
}


sub MAIN (Int:D $locus, *@input) {

    ## 1. convert the input commandline array into a linked list
    my $list = LinkedList.new();
    $list.populate_from_array( @input );

    my $before = LinkedList.new();
    my $after  = LinkedList.new();
    my $node   = $list.first;

    ## 2a. if it is less than the given value, add it to
    ##     the end of the before list
    ## 2b. if it is more than or equal to the given value
    ##     add it to the end of the after list
    ## if a sublist isn't started, start it with the node
    while $node.defined {
        my $sublist = $node.value < $locus ?? $before !! $after;
        $sublist.last.defined ?? $sublist.last.next
                              !! $sublist.first       = $node;
        $sublist.last = $node;
        $node = $node.next;
    }

    ## 3. link the pre list to the post list:
    ## 3a. point the last element of the pre list to
    ##     the first element of the post
    ## 3b. point the last element of the post list to null
    $before.last.next = $after.first if defined $before.last;
    $after.last.next  = Nil if defined $after.last;

    # output
    $list.arrow_print();
}
