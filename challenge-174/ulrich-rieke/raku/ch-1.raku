use v6 ;

sub isDisarium( Int $n is copy --> Bool ) {
  my @digits = (~$n).comb.map( {.Int} ) ;
  my Int $sum = 0 ;
  for (1 .. @digits.elems ) -> $i {
      $sum += @digits[ $i - 1] ** $i ;
  }
  return $sum == $n ;
}

my @disariums ;
my Int $current = 0 ;
while ( @disariums.elems != 19 ) {
  if ( isDisarium( $current ) ) {
      @disariums.push( $current ) ;
  }
  $current++ ;
}
.say for @disariums ;
