use v6 ;

sub mySubstitution( Str $word is copy ) {
  my $count = 0 ;
  my $pos = 0 ;
  while ( $count < 4 ) {
      if ( $word.substr( $pos , 1 ) ~~ /\w/ ) {
    $word.substr-rw( $pos , 1 ) = "x" ;
    $count++ ;
    $pos++ ;
      }
      else {
    $pos++ ;
      }
  }
  return $word ;
}

say "Enter some strings, separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.split( /\s/ ) ;
my @transformed = @words.map( { mySubstitution( $_ ) } ) ;
say @transformed.join( ',' ) ;
