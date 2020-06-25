use v6 ;

#`(dividing is subtracting repeatedly. First we operate on absolute
  numbers, then we differentiate by differing signs)
sub myDivide( Int $numa , Int $numb --> Int ) {
  my $firstnum = abs( $numa ) ;
  my $secondnum = abs( $numb ) ;
  my $result ;
  if ( $firstnum < $secondnum ) {
      $result = 0 ;
  }
  if ( $firstnum == $secondnum ) {
      $result = 1 ;
  }
  if ( $firstnum > $secondnum ) {
      my $count = 1 ;
      my $num = $secondnum ;
      while ( $num < $firstnum ) {
    $num += $secondnum ;
    $count++ ;
      }
      $result = --$count ;
  }
  unless samesign( $numa , $numb ) {
      $result *= -1 ;
      if ( abs( $result ) != 1 ) {
    $result -= 1 ;
      }
  }
  return $result ;
}

sub samesign( Int $a , Int $b --> Bool ) {
  return ($a >= 0 && $b > 0 ) || ( $a < 0 && $b < 0) ;
}

sub MAIN( Int $M , Int $N) {
  say myDivide( $M , $N ) ;
}
