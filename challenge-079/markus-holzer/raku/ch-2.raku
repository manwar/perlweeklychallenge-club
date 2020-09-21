unit sub MAIN( *@N where @N.all ~~ Int );

say (@N.max...0)
        .map( -> $height {
            @N.pairs.grep( *.value >= $height ).map: *.key })
        .map( -> $indexes {
            $indexes.rotor(2 => -1) })
        .map( -> $index-pairs {
            $index-pairs.map({ .[1] - .[0] - 1 if .elems }).sum })
        .sum;