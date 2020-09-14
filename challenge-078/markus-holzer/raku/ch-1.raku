unit sub MAIN( *@A where @A.all ~~ Int );

say @A.&leader-elements.join: ", ";

multi leader-elements( @A ) {
    (^@A)
        .grep( -> $i { @A[ $i ] > @A[ $i^..* ].all } )
        .map(  -> $i { @A[ $i ]                    } ) }

multi leader-elements( @A where +@A == 0 ) { 0 }