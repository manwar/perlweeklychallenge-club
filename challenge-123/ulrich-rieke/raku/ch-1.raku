use v6 ;

#find all divisors starting with 2, keep dividing until the number
#passed as argument is equal to 1
sub isUgly( Int $N is copy --> Bool ) {
  my @divisors ;
  my $current = 2 ;
  while ( $N > 1 ) {
      if ( $N %% $current ) {
    @divisors.push( $current ) ;
        $N div= $current ;
      }
      else {
    $current++ ;
      }
  }
  return @divisors.Set (<=) (2 , 3 , 5 ).Set ;
}

sub MAIN( Int $n ) {
  my $current = 1 ;
  my $sumUglies = 1 ;#we consider 1 an ugly number , so we start with 1
#ugly number
  while ( $sumUglies < $n ) {
      $current++ ;
      if ( isUgly( $current ) ) {
    $sumUglies++ ;
      }
  }
  say $current ;
}
