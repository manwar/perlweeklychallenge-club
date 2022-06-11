use v6 ;

sub squareDigits( Int $n is copy --> Int ) {
  my $numberString = ~$n ;
  my Int @numbers = $numberString.comb.map( { $_.Int ** 2 } ) ;
  return [+] @numbers ;
}

sub isHappy( Int $n is copy --> Bool ) {
  my %seen ;
  my Int $sum = $n ;
  repeat {
      $sum = squareDigits( $sum ) ;
      %seen{$sum}++ ;
  } until ( $sum == 1 || %seen{ $sum } > 1 ) ;
  return ( $sum == 1 ) ;
}

my Int @happies ;
my Int $current = 1 ;
while ( @happies.elems != 8 ) {
  if ( isHappy( $current ) ) {
      @happies.push( $current ) ;
  }
  $current++ ;
}
say @happies.join( ',' ) ;
