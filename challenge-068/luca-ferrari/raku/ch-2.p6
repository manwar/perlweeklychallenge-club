#!raku

class Node {
      has Str $.value is rw;
      has Node $.next is rw;
}


sub MAIN() {
    # build the list
    my Node $root = Node.new( :value( "L0" ) );
    my Node $current-node = $root;
    for 0 ^..^ 10 {
        $current-node.next = Node.new( :value( "L$_" ) );
        $current-node = $current-node.next;
    }



    # convert into an array
    my @nodes;
    $current-node = $root;
    while ( $current-node ) {
        @nodes.push: $current-node;
        $current-node = $current-node.next;
    }


    # sort into another array
    my @new-nodes;
    for 0 ..^ @nodes.elems / 2 {
        "switching elements $_ and { @nodes.elems - $_ - 1 }".say;
        @new-nodes.push: @nodes[ $_ ];
        @new-nodes.push: @nodes[ @nodes.elems - $_ -1 ];

    }

    # debug printing
    # for 0 ..^ @new-nodes.elems {
    #     say @new-nodes[ $_ ].value;
    # }

    # now adjust linked references
    for 0 ..^ @new-nodes.elems - 1 {
        @new-nodes[ $_ ].next = @new-nodes[ $_ + 1 ];
    }

    @new-nodes[ @new-nodes.elems - 1 ].next = Nil;

    # all done
    $root.say;
}
