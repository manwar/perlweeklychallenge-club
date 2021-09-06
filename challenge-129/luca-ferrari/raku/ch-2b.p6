#!raku


sub MAIN() {
    my @L1 = 1 , 2 , 3 , 4 , 5;
    my @L2 = 6 , 5 , 5;

    my @sums;
    my $carry = 0;

    for 1 .. max( @L1.elems, @L2.elems ) {
        my $sum = ( @L1.elems >= $_ ?? @L1[ * - $_ ] !! 0 )
                      + ( @L2.elems >= $_ ?? @L2[ * - $_ ] !! 0 )
                      + $carry;
        $carry = 0;
        ( $sum, $carry ) = ( $sum % 10, ( $sum / 10 ).Int ) if $sum >= 10;
        @sums.push: $sum;
    }

    @sums.join( ' -> ' ).say;
}
