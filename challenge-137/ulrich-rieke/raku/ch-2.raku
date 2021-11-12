use v6 ;

sub isPalindrome( Int $m is copy ) {
  return ~$m eq ~$m.flip ;
}

subset Allowed of Int where 10 <= * <= 10000 ;
sub MAIN( Allowed $n is copy ) {
  my $iternum = 0 ;
  my $number = $n ;
  my $output = 1 ;
  while ( $iternum < 500 ) {
      my $numberstring = ~$number ;
      $number = $number + $numberstring.flip.Int ;
      if ( isPalindrome( $number ) ) {
    $output = 0 ;
    last ;
      }
      if ( $number >= 10000000 ) {
    $output = 1 ;
    last ;
      }
      $iternum++ ;
  }
  if ( $iternum >= 500 ) {
      $output = 1 ;
  }
  say $output ;
}
