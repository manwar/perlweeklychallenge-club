use v6 ;

sub reduceStr( $string is rw ) {
   while ( $string ~~ /'#'/ ) {
      my $pos =  $string.index( '#' ) ;
      my $firstpart = $string.substr( 0 , $pos - 1 ) ;
      if ( $pos < $string.chars - 1 ) {
	 my $secondpart = $string.substr( $pos + 1 ) ;
	 $string = $firstpart ~ $secondpart ;
      }
      else {
	 $string = $firstpart ;
      }
   }
   return $string ;
}

say "Enter 2 strings with zero or more #!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say (reduceStr(@words[0]) eq reduceStr(@words[1])) ;
