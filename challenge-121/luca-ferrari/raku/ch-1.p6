#!raku


sub MAIN( Int $m where { 0 <= $m <= 255 }
          , Int $n where { 1 <= $n <= 8 } ) {
    my @bits = '%08d'.sprintf( $m.base( 2 ) ).split( '', :skip-empty );
    
    @bits[ * - $n ] = @bits[ * - $n ] == 1 ?? 0 !! 1;
    
    @bits.join.parse-base( 2 ).say;
}
