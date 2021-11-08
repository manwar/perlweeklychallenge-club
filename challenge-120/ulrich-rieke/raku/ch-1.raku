use v6 ;

sub fillWithNils( Str $number is rw --> Str ) {
  my Str $firstNibble ;
  my Str $secondNibble ;
  my $len = $number.chars ;
  given $len {
      when * < 4  {
        $firstNibble = "0" x ( 4 - $len ) ~ $number ;
        $secondNibble = "0" x 4 ;
      }
      when 4 {
        $firstNibble = $number ;
        $secondNibble = "0" x 4 ;
      }
      when * > 4 && * < 8 {
    $firstNibble = "0" x (8 - $len ) ~ $number.substr( 0 , $len - 4 ) ;
        $secondNibble = $number.substr( $len - 4 ) ;
      }
      when 8 { return $number }
  }
  $number = $firstNibble ~ $secondNibble ;
  return $number ;
}

sub MAIN( Int $N is copy ) {
  my Str $toBaseTwo = $N.base( 2 ) ;
  my Str $filledUp = fillWithNils( $toBaseTwo ) ;
  my Str $swapped ;
  for (1 , 3 , 5 , 7 ) -> $i {
      $swapped ~= $filledUp.substr( $i , 1 ) ;
      $swapped ~= $filledUp.substr( $i - 1 , 1 ) ;
  }
  say $swapped.parse-base( 2 ) ;
}
