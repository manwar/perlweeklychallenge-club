use v6 ;

sub MAIN( Int $m , Int $n ) {
  .say for (1...$m).combinations( $n ) ;
}
