use v6 ;

sub MAIN( Str $sedol is copy ) {
  my Bool $valid = False ;
  my Str $teststring = $sedol.uc ;
  if ( $teststring !~~ /^\w ** 7$/ || $teststring ~~ /<[AEIOU]>/
    || $teststring ~~ /'_'/ ) {
      $valid = False ;
  }
  else {
      my @factors = ( 1, 3 , 1 , 7 , 3 , 9 , 1 ) ;
      my Int $sum = 0 ;
      for (0 .. 5 ) -> $i {
    my $letter = $teststring.substr( $i , 1 ) ;
    if ( $letter ~~ /<digit>/ ) {
        $sum += +$letter * @factors[ $i ] ;
    }
    if ( $letter ~~ /<upper>/ ) {
        $sum += (ord( $letter ) - 55) * @factors[ $i ] ;
    }
      }
      if ( $teststring.substr( 6 , 1 ).Int == ( 10 - ( $sum % 10 ) ) % 10 ) {
    $valid = True ;
      }
  }
  if ( $valid ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
