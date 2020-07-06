#!/usr/bin/env raku

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

    method move-node( ListNode $start, ListNode $node ) {
        my $prev = $start;
        my $next = $!next;
        my $node-next = $node.next;
        while $prev.next !~~ $node { $prev = $prev.next }
        $!next = $node;
        $node.add-next( $next );
        $prev.add-next( $node-next );
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

sub MAIN( *@values where *.elems >= 1 ) {
    my $start-node = ListNode.from-iterator( @values );
    say "Input  : {$start-node.gist}";
    my $end-node = $start-node.last-node;
    my $current-node = $start-node;
    while ! $current-node.is-last {
        my $next-node = $current-node.next;
        if ! $next-node.is-last {
            $current-node.move-node( $start-node, $end-node );
            $end-node = $current-node.last-node;
        }
        $current-node = $next-node;
    }
    say "Output : {$start-node.gist}";
}
