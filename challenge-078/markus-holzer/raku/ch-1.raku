unit sub MAIN( *@A where @A.all ~~ Int );

say "({ join ", ", leader-elements( @A ) })";

sub leader-elements( @stuff ) {
    sub find( $that, *@the-rest ) {
        take $that if $that > all @the-rest;
        find |@the-rest if @the-rest }

    +@stuff ?? gather find |@stuff !! 0 }

#
#sub leader-elements( @A ) {
#    (^@A)
#        .grep( -> $i { @A[ $i ] > @A[ $i^..* ].all } )
#        .map(  -> $i { @A[ $i ]                    } ) }
