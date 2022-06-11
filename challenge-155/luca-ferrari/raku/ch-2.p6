#!raku

sub MAIN( Int $nth where { $nth >= 3 } = 3,
          Int $accuracy where { $accuracy > 1 } = 5,
          Bool :$verbose = False ) {

    my @fibonacci = 0, 1, 1, 2, * + * ... *;
    my @pisano    = @fibonacci.map: * % 3;

    # with nth >= 3 the period is always even
    my $period = 2;

    # build $accuracy arrays to check
    my @checking.push: @pisano[ ( 0 + $period * $_ ) .. ( $period * ( $_  + 1 ) ) - 1 ] for 1 .. $accuracy;

    # while the array are not all the same, grow them and recheck
    while ( not [eqv] @checking ) {
        $period += 2;
        @checking = ();
        @checking.push: @pisano[ ( 0 + $period * $_ ) .. ( $period * ( $_  + 1 ) ) - 1 ] for 1 .. $accuracy;
    }

    @checking.join( "\n" ).join( ',' ).say if $verbose;
    "Pisano period $nth is $period".say;

}
