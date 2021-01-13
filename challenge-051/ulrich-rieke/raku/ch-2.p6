use v6 ;

sub isColourful( Int $n --> Bool ) {
  my $numstr = $n.Str ;
  my @products ;
  if ( $numstr ~~ /(\d) (\d) (\d)/ ) {
      @products.push( +$0 * +$1 , +$1 * +$2 , +$0 * +$1 * +$2 , +$0 , +$1 , +$2 , +$0 * +$2 ) ;
      my $numberset = @products.Set ;
      return $numberset.elems == 7 ;
  }
  else {
      return False ;
  }
}

.say for (100..999).grep( { isColourful( $_ ) } ) ;
