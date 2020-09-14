unit sub MAIN( *@numbers where @numbers.all ~~ Int );

say "({ join ", ", leader-elements @numbers })";

sub leader-elements( @stuff ) {
    my $max = 0;
    reverse @numbers.reverse.grep: -> $n { $n > $max ?? ($max = $n) !! 0 } }

#sub leader-elements-recursive( @stuff ) {
#    sub find( $that, *@the-rest ) {
#        take $that      if $that > all @the-rest;
#        find |@the-rest if @the-rest }
#
#    +@stuff ?? gather find |@stuff !! 0 }

#
#sub leader-elements-filter( @A ) {
#    (^@A)
#        .grep( -> $i { @A[ $i ] > @A[ $i^..* ].all } )
#        .map(  -> $i { @A[ $i ]                    } ) }
