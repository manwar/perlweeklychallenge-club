#!env raku

# Task 2
# N-queens

# Places the queen into the chessboard at the indicated coordinates.
# Also setto False every square the queen can reach.
sub place-queen( @chessboard, $row, $column, $height, $dimension ){

    for 0 ..^ $dimension {
        @chessboard[ $row ][ $_ ][ $height ]    = False;
        @chessboard[ $row ][ $column ][ $_ ]    = False;
        @chessboard[ $_ ][ $column ][ $height ] = False;
    }

    # diagonal (only on one level)
    for 0 ..^ $dimension {
        @chessboard[ $row + $_ ][ $column + $_ ][ $height ] = False if ( $row + $_ < $dimension && $column + $_ < $dimension);
        @chessboard[ $row - $_ ][ $column - $_ ][ $height ] = False if ( $row - $_ >= 0 && $column - $_ >= 0 );
        @chessboard[ $row - $_ ][ $column + $_ ][ $height ] = False if ( $row - $_ >= 0 && $column + $_ < $dimension );
        @chessboard[ $row + $_ ][ $column - $_ ][ $height ] = False if ( $row + $_ < $dimension && $column - $_ >= 0 );
    }

    @chessboard[ $row ][ $column ][ $height ] = 'QUEEN';
}


#
# Show every level of the chessboard.
#
sub show-chessboard( @chessboard, $dimension ) {
    for 0 ..^ $dimension -> $height {
        say "Layer $height";

        for 0 ..^ $dimension -> $row {
            for 0 ..^ $dimension -> $column {
                given @chessboard[ $row ][ $column ][ $height ] {
                    when Str { print "\t ", @chessboard[ $row ][ $column ][ $height ]; }
                    default  { print "\t  x  "; }
                }

            }

            print "\n";
        }
    }
}

sub MAIN( Int $dimension = 3 ){
    my @chessboard = [[True xx $dimension] xx $dimension] xx $dimension;
    
    for 0 ..^ $dimension -> $height {
        for 0 ..^ $dimension -> $row {
            for 0 ..^ $dimension -> $column {
    
                # is the cell available?
                next if ! @chessboard[ $row ][ $column ][ $height ];

                # # place the queen
                place-queen( @chessboard, $row, $column, $height, $dimension );
            }
        }
    }


    show-chessboard( @chessboard, $dimension );                
}
