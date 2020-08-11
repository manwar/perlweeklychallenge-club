use v6 ;

sub findTriplets( Int $sum, @array ) {
  my $len = @array.elems ;
  my @result ;
  if ( $len < 3 ) {
      return ( ) ;
  }
  for (0..$len - 2 ) -> $i {
      my $a = @array[ $i ] ;
      my $start = $i + 1 ;
      my $end = $len - 1 ;
      while ( $start < $end ) {
    my $b = @array[ $start ] ;
    my $c = @array[ $end ] ;
    if ( $a + $b + $c == $sum ) {
        my $partialresult.push( $a , $b , $c ) ;
        @result.push( $partialresult ) ;
        $start++ ;
        $end-- ;
    }
    elsif ( $a + $b + $c > $sum ) {
        $end-- ;
    }
    else {
        $start++ ;
    }
      }
  }
  return @result ;
}

my @L = (-25 , -10 , -7 , -3 , 2 , 4 , 8 , 10 ) ;
my @sorted = @L.sort ;
my @result = findTriplets( 3 , @sorted ) ;
if ( @result ) {
  .say for @result ;
}
else {
  say "No triplets this time!" ;
}
