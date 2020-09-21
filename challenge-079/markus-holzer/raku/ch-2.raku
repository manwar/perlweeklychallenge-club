unit sub MAIN( *@N where @N.all ~~ Int );

sub index-find { @N.pairs.grep( *.value >= $^h ).map: *.key }
sub index-diff { ($^i.cache.skip >>->> $^i).map: * - 1 }

say (@N.max...0)
    .map( &index-find )
    .map( &index-diff )
    .flat
    .sum;