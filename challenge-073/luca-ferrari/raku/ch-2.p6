#!raku

# % raku ch-2.p6 7 8 3 12 10
#     0,7,0,3,3


# % raku ch-2.p6 4 6 5      
#     0,4,4


sub MAIN( *@A where { @A.grep( * ~~ Int ).elems == @A.elems } ) {
    my @mins;
    for 0 ..^ @A.elems {
        my $current-min = $_ == 0 ?? 0 !! [min] @A[ 0 ..^ $_ ];
        @mins.push: $current-min < @A[ $_ ] ?? $current-min !! 0;
    }

    @mins.join( ',' ).say;
}
