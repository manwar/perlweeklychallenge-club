use v6 ;

sub findValley( @array, $pos ) {
  my $len = @array.elems ;
  my $currentPos = $pos ;
  repeat { #supposed to be the descent , go until elements get larger
      $currentPos++ ;
  } until ( $currentPos == $len || @array[$currentPos] >
    @array[$currentPos - 1] ) ;
  my @result ;
  if ( $currentPos == $len ) { #we are at the end of the array, store
  #result
      @result = ( $pos , $currentPos - 1 - $pos) ;
  }
  else { #keep going until either the end of the array or until
  #elements get smaller again
      repeat {
    $currentPos++ ;
      } until ( $currentPos == $len || @array[ $currentPos ] <
        @array[ $currentPos - 1]) ;
      @result = ( $pos , $currentPos - 1 - $pos ) ;
  }
  return @result ;
}

say "Enter some digits, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @positions ;
my $len = @numbers.elems ;
for (0..$len - 2) -> $i {
  my @result = findValley( @numbers , $i ) ;
  @positions.push( @result ) ;
}
my @sorted = @positions.sort( { @^b[1] <=> @^a[1] || @^a[0] <=>
      @^b[0] } ) ;
my $startpos = @sorted[0][0] ;
my $stride = @sorted[0][1] ;
say @numbers[$startpos..$startpos + $stride].join( ", " ) ;
