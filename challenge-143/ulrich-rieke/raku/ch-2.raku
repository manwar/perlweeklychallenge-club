use v6 ;

subset Positive of Int where * > 0 ;
sub MAIN( Positive $n ) {
  my @divisors ;
  my $output = 0 ;
  for ( 1 .. $n ) -> $i {
      if ( $n %% $i ) {
    @divisors.push( $i ) ;
      }
  }
  my @combis = @divisors.combinations( 2 ).map( {.Array} ) ;
  if ( sqrt( $n ) %% 1 ) {
      my $root = sqrt( $n ) ;
      my @array = ( $root , $root ) ;
      @combis.push( @array ) ;
  }
  if ( @combis.elems > 1 ) {
      my @suitable_Pairs = @combis.grep( {$_[0] * $_[1] == $n} ) ;
      if ( @suitable_Pairs.elems > 1 ) {
    my %seen ;
    my $pair = @suitable_Pairs.shift( ) ;
    %seen{ $pair.join( '|' )}++ ;
    while ( %seen{ $pair.join( '|' ) } < 2 ) {
        if ( @suitable_Pairs.grep( { $pair[ 0 ] + $pair[ 1] ==
            $_[0] + $_[1] + 1 } ).elems > 0 ) {
          $output = 1 ;
              last ;
        }
        else {
          @suitable_Pairs.push( $pair ) ;
          $pair = @suitable_Pairs.shift ;
          %seen{ $pair.join( '|' )}++ ;
        }
    }
      }
      else {
    $output = 0 ;
      }
  }
  else {
      $output = 0 ;
  }
  say $output ;
}
