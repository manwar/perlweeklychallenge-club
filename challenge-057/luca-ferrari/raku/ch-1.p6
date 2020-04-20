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



sub print( $left, $right, $height ) {
    my $message = "%s %s %s".sprintf: "  " x $height,
        $left ?? $left.value !! " ",
        $right ?? $right.value !! " ";

    $message ~= print( $left.left, $left.right, $height - 1 ) if $left;
    $message ~= print( $right.left, $right.right, $height- 1 ) if $right;
    return $message;
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
    #    put $root.Str;
    say print $root, Nil, 5;

}
