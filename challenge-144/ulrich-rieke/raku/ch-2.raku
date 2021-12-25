use v6 ;

sub count( @array , Int $needle ) {
  my $counted = 0 ;
  for @array -> $number {
      if ( $number == $needle ) {
    $counted++ ;
      }
  }
  return $counted ;
}

sub MAIN( Int $u , Int $v ) {
  my @ulams = ( $u , $v ).sort( { $^a <=> $^b } ) ;
  while ( @ulams.elems < 10 ) {
      if ( @ulams.elems == 2 ) {
    @ulams.push( [+] @ulams ) ;
      }
      else {
    my @combis = @ulams.combinations( 2 ) ;
    my @sums = @combis.map( {$_[0] + $_[1] } ).sort ;
    my $elements = @sums.elems ;
    my $i = 0 ;
        while ( $i < $elements ) {
        if ( @sums[ $i ] > @ulams[ *-1 ] && count( @sums , @sums[ $i ] )
          == 1 ) {
          @ulams.push( @sums[ $i ] ) ;
          last ;
        }
        else {
          $i++ ;
        }
    }
      }
  }
  say @ulams ;
}
