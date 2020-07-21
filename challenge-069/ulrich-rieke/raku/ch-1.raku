use v6 ;

sub isStrobo( Int $n --> Bool ) {
  my %strobopairs = "6" => "9" , "8" => "8" , "9" => "6" , "0" => "0" ;
  my $numstring = ~$n ;
  my $len = $numstring.chars ;
  for (0..$len - 1 ) -> $i {
      unless ( %strobopairs{ $numstring.substr( $i , 1 ) }:exists ) {
    return False ;
      }
  }
  my $downsided = $numstring.flip.comb.map( { %strobopairs{ $_ } } ).join ;
  return $numstring eq $downsided ;
}

sub MAIN( Int $A , Int $B ) {
  if ( $A > $B ) {
      say "No valid range!" ;
      say "second int must be greater than first!" ;
      exit( 1 ) ;
  }
  .say for ($A..$B).grep( { isStrobo( $_ ) } ) ;
}
