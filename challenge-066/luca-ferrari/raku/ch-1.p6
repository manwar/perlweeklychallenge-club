#!env raku

# You are given two integers $M and $N.

# Write a script to divide the given two integers i.e. $M / $N without using multiplication, division and mod operator and return the floor of the result of the division.


sub MAIN( Int :$M, Int :$N ){
    # extract both the signs
    my ( $signM, $signN ) = $M > 0 ?? 1 !! -1, $N > 0 ?? 1 !! -1;
    my ( $numerator, $denominator ) = abs( $M ), abs( $N );


    my ($result, $remind) = 0, $numerator;
    while ( $remind >= $denominator ) {
        $result++;
        $remind -= $denominator;
    }

    # this is a sign multiplication, it has nothing to do
    # with computing the result
    $result *= $signM * $signN;
    "$M / $N = $result (remind $remind)".say;

}
