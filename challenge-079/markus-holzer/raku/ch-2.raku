unit sub MAIN( *@N where @N.all ~~ Int );

sub index-height { @N.pairs.grep( *.value >= $^height ).map: *.key }
sub index-diff   { $^indexes.map({ .[1] - .[0] - 1 if .elems }).sum }

say (@N.max...0)
    .map( &index-height )
    .map( *.rotor: 2 => -1 )
    .map( &index-diff )
    .sum;