#!env raku

# You are given an array @N of positive integers (sorted)
# and another non negative integer k.
#
# Write a script to find if there exists 2 indices i and j
# such that A[i] - A[j] = k and i != j.
#
# It should print the pairs of indices, if any such pairs exist.
#
#  Example:
#
#    @N = (2, 7, 9)
#    $k = 2
#
#    Output : 2,1


sub MAIN( Int:D :$K,  *@N ) {
    say "Array { @N } and index $K";
    for 0 ..^ @N.elems -> $i {
        for $i ^..^ @N.elems -> $j {
        say "$i, $j ---> { @N[ $i ] } <-> { @N[ $j ] }"
            if ( @N[ $i ] - @N[ $j ] == any( $K, $K * -1 ) )
        }
    }
}
