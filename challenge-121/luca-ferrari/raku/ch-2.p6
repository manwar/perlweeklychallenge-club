#!raku


sub find-city-path( @matrix, $row-number, $allow-zero ) {
    my @row = @matrix[ $row-number ].List;
    my $min-distance = @row.max + 1;
    my $current-city = 0;
    my $city = -1;

    
    for @row -> $distance {
        
        $city++;
        next if $distance == 0 && ! $allow-zero;

        if ( $distance < $min-distance ) {
            $current-city = $city;
            $min-distance = $distance;
        }
        
    }

    
    
    return [ $min-distance, $current-city ];
}


sub MAIN() {
    my @matrix = [0, 5, 2, 7]
        , [5, 0, 5, 3]
        , [3, 1, 0, 6]
        , [4, 5, 4, 0];

    my @path;
    my $cities-left = @matrix[ 0 ].elems;

    
    my ( $distance, $city ) = Nil, 0;
    while ( $cities-left > 0 ) {
        ( $distance, $city ) = find-city-path( @matrix, $city, $cities-left == @matrix[ 0 ].elems );
        @path.push: $distance;
        $cities-left--;
        
        
    }

    @path.push: 0;

    @path.say;
}
