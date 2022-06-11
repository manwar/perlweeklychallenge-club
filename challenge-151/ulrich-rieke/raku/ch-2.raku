use v6 ;

#we check whether there is a difference of only one between any two numbers
sub checkCondition( @array --> Bool) {
  my $len = @array.elems ;
  for (0 .. $len - 2 ) -> $i {
      if ( abs( @array[ $i ] - @array[ $i + 1 ] ) == 1 ) {
    return False ;
      }
  }
  return True ;
}

say "Enter digits representing the valuables in a house, divided by space!" ;
my $values = $*IN.get ;
my @valuables = $values.split( /\s+/ ).map( {.Int} ) ;
my $len = @valuables.elems ;
if ( $len == 1 ) {
  say @valuables[0] ;
}
elsif ( $len == 2 ) {
  say @valuables.max ;
}
else {
  if ( $len == 3 ) {
      if ( @valuables[0] + @valuables[2] > @valuables[1] ) {
    say ( @valuables[0] + @valuables[2] ) ;
      }
      else {
    say @valuables[1] ;
      }
  }
  else { # $len > 3
      my @robbedValues ;
      my @combilengths ;
      if ( $len % 2 == 1 ) {
    #if we have an odd number of elements we have to check combinations
    #of (($len div 2) + 1 ) and ( $len div 2 )
    @combilengths.push( ($len div 2) + 1 , $len div 2 ) ;
      }
      else {
    @combilengths.push( $len div 2 ) ;
      }
      my @suitableCombis ;
      for @combilengths -> $combilen {
    my @combis = ( 0 .. $len - 1 ).combinations( $combilen ).map( {.Array} ) ;
    #find all combinations with no adjacent houses
    @suitableCombis = @combis.grep( { checkCondition( |@_ ) } ) ;
    for @suitableCombis -> @subcombi {
        @robbedValues.push( @valuables[ @subcombi ].sum  ) ;
    }
      }
      say @robbedValues.max ;
  }
}
