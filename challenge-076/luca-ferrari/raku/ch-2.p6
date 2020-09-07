#!raku



sub diagonal-words( @grid-chars,  $up-to-down = True, $left-to-right = True ) {
    my @diagonals;
    my ( $row, $column ) = $up-to-down ?? 0 !! @grid-chars.elems - 1,
                           $left-to-right ?? 0 !! @grid-chars[ 0 ].elems - 1;

    my ( $row-increment, $column-increment ) = $up-to-down    ?? 1 !! -1,
                                               $left-to-right ?? 1 !! -1;

    my ( $last-row, $last-column ) = $row, $column;
    my @word;
    while ( $last-row ~~ 0 ..^ @grid-chars.elems
            && $last-column ~~ 0 ..^ @grid-chars[0].elems ) {

        ( $last-row, $last-column ) = $row, $column;
        while ( $last-column ~~ 0 ..^ @grid-chars[0].elems ) {
            @word = ();
            while ( $row ~~ 0 ..^ @grid-chars.elems
                    && $column ~~ 0 ..^ @grid-chars[0].elems ) {
                @word.push: @grid-chars[ $row ][ $column ];
                $row += $row-increment;
                $column += $column-increment;
            }

            @diagonals.push: @word.join, @word.join.flip;
            $last-column += $column-increment;
            ($row, $column) = $last-row, $last-column;
        }

    }

    @diagonals.grep( *.chars > 2 );

}




sub MAIN( $grid-file-name = 'grid.txt',
          $word-file-name = '/usr/share/dict/words',
          $min-length = 3 ) {
    say "Searching words from $word-file-name into grid $grid-file-name";
    my @found-words;


    # get all the lines in the grid lowercase
    my @grid-chars = $grid-file-name.IO.lines.map( *.lc.split( /\s/, :skip-empty ).Array ).Array;

    my ( @horizontals, @verticals, @diagonals );
    for @grid-chars {
        @horizontals.push: .join, .join.flip;
    }

    for ( [Z] @grid-chars ) {
        @verticals.push: .join, join.flip;
    }


    @diagonals.push: diagonal-words( @grid-chars, True, True );
    @diagonals.push: diagonal-words( @grid-chars, True, False );
    @diagonals.push: diagonal-words( @grid-chars, False, True );
    @diagonals.push: diagonal-words( @grid-chars, False, False );


    for $word-file-name.IO.lines  {
        next if .chars < $min-length;
        my $current-word = $_.lc;
        @found-words.push: $current-word if ( @diagonals.grep( * ~~ / $current-word / )
                                              || @horizontals.grep( * ~~ / $current-word / )
                                              || @verticals.grep( * ~~ / $current-word / ) );
    }

    say "Found { @found-words.elems }  words: { @found-words.join( ',' ) }";
}
