#!env raku


#     5
#    / \
#    4   8
#    /   / \
#    11  13  9
#    /  \      \
#    7    2      1


class Node {
    has Int:D  $.value = 0;
    has Node $.left is rw;
    has Node $.right is rw;
    has Node $.parent is rw;
    has Bool $.is-leaf = False;
}


sub MAIN() {
    my $target = 22;

    my $root                = Node.new( :value( 5 )  );
    $root.left              = Node.new( :value( 4 ), :parent( $root ) );
    $root.right             = Node.new( :value( 8 ), :parent( $root ) );
    $root.left.left         = Node.new( :value( 11 ), :parent( $root.left ) );
    $root.right.left        = Node.new( :value( 13 ), :parent( $root.right ), :is-leaf );
    $root.right.right       = Node.new( :value( 9 ), :parent( $root.right ) );
    $root.left.left.left    = Node.new( :value( 7 ),  :parent( $root.left.left ), :is-leaf );
    $root.left.left.right   = Node.new( :value( 2 ), :parent( $root.left.left ), :is-leaf );
    $root.right.right.right = Node.new( :value( 1 ), :parent( $root.right.right ), :is-leaf );


    my @nodes = $root
        , $root.left             
        , $root.right            
        , $root.left.left        
        , $root.right.left       
        , $root.right.right      
        , $root.left.left.left   
        , $root.left.left.right  
        , $root.right.right.right;



    # find the leaves
    my @leaves = @nodes.grep( *.is-leaf );


    # now walk from the leaves to the root
    for @leaves  {
        my @path = [ .value ];
        my $node = $_;
        @path.push: $node.value while ( $node = $node.parent );
        my $sum = [+] @path;
        say "Sum is $sum with the path { @path.reverse }" if ( $sum == $target );
    }

}
