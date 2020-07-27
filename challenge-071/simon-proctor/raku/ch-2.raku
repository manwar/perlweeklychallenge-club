#!/usr/bin/env raku

# Linked List Implementation modified from Challenge 68
class ListNode {
    has $.value;
    has ListNode $!next;

    method is-last() {
        ! $!next.defined;
    }

    method next() {
        $!next;
    }
    
    method add-next( ListNode $next ) {
         $!next = $next;
    }

    method remove-next() {
        if ( $!next.is-last ) {
            $!next = ListNode;
        } else {
            $!next = $!next.next;
        }
    }
    
    method move-node( ListNode $start, ListNode $node ) {
        my $prev = $start;
        my $next = $!next;
        my $node-next = $node.next;
        while $prev.next !~~ $node { $prev = $prev.next }
        $!next = $node;
        $node.add-next( $next );
        $prev.add-next( $node-next );
    }

    method length( $count = 1 ) {
        if self.is-last {
            return $count;
        } else {
            return $!next.length( $count+1 );
        }
    }
    
    method gist() {
        if self.is-last {
            "$.value";
        } else  {
            "{$.value} -> {$!next.gist}";
        }
    }

    method from-iterator( ListNode:U : @values ) {
        my ( $start-node, $node );
        
        for @values -> $value {
            if ! $start-node.defined {
                $start-node = ListNode.new( :$value );
                $node = $start-node;
            } else {
                my $next-node = ListNode.new( :$value );
                $node.add-next( $next-node );
                $node = $next-node;
            }        
        }
        return $start-node;
    }

    method last-node() {
        my $node = self;
        while ! $node.is-last { $node = $node.next(); }
        return $node;
    }
}

sub MAIN (
    UInt $N where * > 0, #= Number from the end to remove if N is greated than list length remove the first item
    *@list, #= List of values 
) {
    my $linked = ListNode.from-iterator(@list);
    say "Before: {$linked.gist}";
    if ( $N >= $linked.length ) {
        $linked = $linked.next;
    } else {
        my $count = $linked.length - 1;
        my $cur = $linked;
        while ( $count > $N ) {
            $count--;
            $cur = $cur.next;
        }
        $cur.remove-next;
    }
    say "After: {$linked.gist}";
}
