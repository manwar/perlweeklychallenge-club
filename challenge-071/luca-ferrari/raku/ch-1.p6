#!raku


sub MAIN( Int $N where { $N > 1 } ) {
    my @array;
    my @peak;

    while ( @array.elems < $N ) {
        my $random = ( 1 .. 50 ).rand.Int;
        @array.push: $random if ( ! @array.grep( * ~~ $random ) );
    }


    for 0 ..^ @array.elems {
        my $neighbour-left  = $_ == 0 ?? Nil !! @array[ $_ - 1 ];
        my $neighbour-right = $_ == ( @array.elems - 1 ) ?? Nil !! @array[ $_ + 1 ];
        my $current         = @array[ $_ ];

        @peak.push: $current if ( $neighbour-left && $current > $neighbour-left )
                             || ( $neighbour-right && $current > $neighbour-right );
    }

    "Array: { @array }".say;
    "Peak:  { @peak  }".say;
}
