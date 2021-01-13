#!env raku

# Perl Weekly Challenge 57
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-057/>
#
# Task 1

class Node {
    has Int  $.value;
    has Node $.left  is rw;
    has Node $.right is rw;


}


sub switch( Node $current-node is rw ) {
    return if ! $current-node
        && ! $current-node.left
        && ! $current-node.right;

    my ( $left, $right ) = ( $current-node.left, $current-node.right );
    $current-node.left  = $right;
    $current-node.right = $left;

    switch( $current-node.left )  if $current-node.left;
    switch( $current-node.right ) if $current-node.right;
}


sub print ( @nodes ) {
    return if ! @nodes;
    
    my $spaces = " " x 6 / @nodes.elems;
    my @children;
    my $line = "";
    my $subline = "";
    loop ( my $i = 0; $i < @nodes.elems; $i++ ) {
        next if ! @nodes[ $i ];
        $line ~= $spaces ~ $spaces x $i;
        $line ~= @nodes[ $i ].value;
        $subline ~= $spaces ~ $spaces x $i;
        $subline ~= "/ \\";
        @children.push: @nodes[ $i ].left, @nodes[ $i ].right;
    }

    say $line;
    say $subline;
    print( @children );
}


sub MAIN() {

    my Node $root     = Node.new( :value( 1 ) );
    $root.left        = Node.new( :value( 2 ) );
    $root.right       = Node.new( :value( 3 ) );
    $root.left.left   = Node.new( :value( 4 ) );
    $root.left.right  = Node.new( :value( 5 ) );
    $root.right.left  = Node.new( :value( 6 ) );
    $root.right.right = Node.new( :value( 7 ) );

    switch( $root );

    print( [ $root ] );

}
