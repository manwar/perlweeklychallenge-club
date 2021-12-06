#!raku

sub MAIN( Int $m where { $m > 1 }
          , Int $n where { $n > 0 && $m > $n } ) {
   ( 1 .. $m ).grep( $m %% * ).grep( * ~~ / ^ \d* $n $ / ).elems.say;
}
