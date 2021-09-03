#!raku

sub MAIN() {
    my @matrix = [ 1 ,0, 0, 0, 1, 0 ],
                 [ 1 ,1, 0, 0, 0, 1 ],
                 [ 1, 0, 0, 0, 0, 0 ];

    my @zeroes;

    for 0 ..^ @matrix.elems -> $current-row {
        for 0 ..^ @matrix[ $current-row ].elems  -> $current-column {
            my $zeroes-count    = 0;
            my $column          = $current-column;
            my $previous-column = $current-column;
            while ( $column < @matrix[ $current-row ].elems && $column - $previous-column <= 1 ) {
                $zeroes-count++ if @matrix[ $current-row ][ $column ] == 0;
                last if @matrix[ $current-row ][ $column ] != 0;
                $previous-column = $column++;
            }

            @zeroes[ $current-row ][ $current-column ] = $zeroes-count;
        }
    }

    
    my $rows = 0;
    my $cols = 0;
    my @sub-matrix;
    my $max  = 0;
    for 0 ..^ @zeroes.elems -> $current-row {
        for 0 ..^ @zeroes[ $current-row ].elems -> $current-column {
            next if @zeroes[ $current-row ][ $current-column ] == 0;
            $cols = @zeroes[ $current-row ][ $current-column ];
            $rows = 1;
            
            
            for $current-row + 1 ..^ @zeroes.elems -> $next-row {
                $rows = 0 and last if @zeroes[ $next-row ][ $current-column ] == 0;
                $rows++ if @zeroes[ $next-row ][ $current-column ] != 0;
                $cols = min( $cols, @zeroes[ $next-row ][ $current-column ] );
            }

            
            $max = $rows * $cols and @sub-matrix = () if $rows * $cols > $max;
            @sub-matrix.push: [ $rows * $cols, $current-row, $current-column, $current-row + $rows - 1, $current-column + $cols - 1 ] if $rows * $cols > 0 && $rows * $cols >= $max;

            


        }
    }

    "{ $_[ 0 ] } zeroes starting from <{ $_[ 1 ] }, { $_[ 2 ]}> to <{ $_[ 3 ] }, { $_[ 4 ]}>".say for @sub-matrix;
    

    

}
