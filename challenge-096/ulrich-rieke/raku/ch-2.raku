use v6 ;

sub levenshtein_dist( Str $A is copy , Str $B is copy --> Int) {
  if ( $B.chars == 0 ) {
      return $A.chars ;
  }
  elsif ( $A.chars == 0 ) {
      return $B.chars ;
  }
  elsif ( $A.substr(0 , 1 ) eq $B.substr(0 , 1 ) ) {
      return levenshtein_dist( $A.substr( 1 ) , $B.substr( 1 ) ) ;
  }
  else {
      my @results ;
      my $tailA = $A.substr( 1 ) ;
      my $tailB = $B.substr( 1 ) ;
      @results.push( levenshtein_dist( $tailA, $B ) ,
        levenshtein_dist( $A , $tailB ) , levenshtein_dist( $tailA ,
          $tailB ) ) ;
      return 1 + @results.min ;
  }
}

sub MAIN( Str $A , Str $B ) {
  say levenshtein_dist( $A , $B ) ;
}
