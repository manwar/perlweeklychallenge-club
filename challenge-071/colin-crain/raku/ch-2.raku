#!/usr/bin/env perl6
# 
# 
#           missing-link.raku
#
#           TASK #2 › Trim Linked List
#             Submitted by: Mohammad S Anwar
#             You are given a singly linked list and a positive
#             integer $N (>0).
# 
#             Write a script to remove the $Nth node from the end
#             of the linked list and print the linked list.
# 
#             If $N is greater than the size of the linked list
#             then remove the first node of the list.
# 
#             NOTE: Please use pure linked list implementation.
# 
#             Example
#                 Given Linked List: 1 -> 2 -> 3 -> 4 -> 5
# 
#                 when $N = 1
#                 Output: 1 -> 2 -> 3 -> 4
# 
#                 when $N = 2
#                 Output: 1 -> 2 -> 3 -> 5
# 
#                 when $N = 3
#                 Output: 1 -> 2 -> 4 -> 5
# 
#                 when $N = 4
#                 Output: 1 -> 3 -> 4 -> 5
# 
#                 when $N = 5
#                 Output: 2 -> 3 -> 4 -> 5
# 
#                 when $N = 6
#                 Output: 2 -> 3 -> 4 -> 5
# 
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



class Node {
    has Any  $.value is rw;
    has Node $.next  is rw;
    
    method terminate {
        $.next = Nil
    }
    
    method lookahead ( Int $distance ) {
    ## looks forward n nodes in list 
    ## returns:
    ## 1 if node is not last node
    ## 0 if node is last node
    ## -1 if list not long enough 
        when ! $.next.defined && $distance > 0 { return -1 }
        when $distance == 0 && $.next.defined  { return  1 }
        when $distance == 0                    { return  0 }
    
        return $.next.lookahead($distance - 1);
    }

}

class LinkedList {
    has Node $.first is rw;
    has Node $!last;                     
    
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
            last if ! $node.next.defined;
            $node = $node.next;
        }
        @output.join(' → ').say;
    }  
    
    method remove_next ( Node $node ) {
    ## splices out the next node and relinks around
        return unless $node.next;
        my $x = $node.next;
        $node.next = $node.next.next;
        $x.terminate;
    }
    
    method remove_head {
    ## remove the first node and resets first to second node
        my $x = $.first;
        $.first = $x.next;
        $x.terminate;
    }

}

multi MAIN () {
    say "Usage: ./missing-link.raku location a1 a2 a3 ...
            location > 0";
}

multi MAIN ( Int $n where { $n > 0 }, *@array ) {

    ## convert the input commandline array into a linked list
    my $list = LinkedList.new;
    $list.populate_from_array( @array );
    $list.arrow_print;
    
    ## unlink the n-th node from the end
    my $node = $list.first;

 LOOK:
    loop {
        given $node.lookahead( $n ) {
            when  0  { $list.remove_next( $node ); last LOOK }
            when -1  { $list.remove_head;          last LOOK }
            $node = $node.next;
        }
    }

    $list.arrow_print;
}



