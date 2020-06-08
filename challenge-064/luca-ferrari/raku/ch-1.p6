#!raku


# Given an m × n matrix with non-negative integers,
# write a script to find a path from top left to bottom
# right which minimizes the sum of all numbers along its path.
# You can only move either down or right at any point in time.
#                                                         Example
#
#                                                         Input:
#
#                                                   [ 1 2 3 ]
#                                                       [ 4 5 6 ]
#                                                       [ 7 8 9 ]
#
#                                                       The minimum sum path looks like this:
#
#                                                   1→2→3
#                                                    ↓
#                                                    6
#                                                    ↓
#                                                    9
#


class Node {
    has $.position;
    has $.value;

    has Node $.right is rw;
    has Node $.down  is rw;

    method adjust( @matrix, $m, $n ){
        my $right = $!position + 1;
        my $down  = $!position + $m;
        $!right = Node.new( :position( $right ), :value( @matrix[ $right ] ) ) if $right < $m;
        $!down  = Node.new( :position( $down ), :value( @matrix[ $down ] ) ) if $down <= $n * $m - 1;

        $!right.adjust: @matrix, $m, $n if $!right;
        $!down.adjust: @matrix, $m, $n  if $!down;
    }

    method get-next-min-path(){
        return $!right if $!right && $!down && $!right.value < $!down.value;
        return $!down;
    }


}





sub MAIN(){
    my @matrix = 1, 2, 3, 4, 5, 6, 7, 8, 9;
    my $m = 3;
    my $n = 3;


    my $start = Node.new( :position( 0 ), :value( @matrix[ 0 ] ) );
    $start.adjust: @matrix, $m, $n;
    my $current-node = $start;
    my $sum = 0;
    my @moves;
    while ( $current-node ) {
        @moves.push: $current-node.value;
        $current-node = $current-node.get-next-min-path;
    }

    say @moves.join( ', ' ) ~ " = " ~ [+] @moves;
}
