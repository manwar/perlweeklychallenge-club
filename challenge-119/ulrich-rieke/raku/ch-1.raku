use v6 ;

#depending on the number of digits in the binary representation we fill up either
#the first or second half of the binary representation with 0's. We have to do
#that from the left end of the first or second half
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
  if ( $N > 255 ) {
      die "We only want to consider numbers up to and including 255!" ;
  }
  my Str $toBaseTwo = $N.base( 2 ) ;
  my Str $filledUp = fillWithNils( $toBaseTwo ) ;
  my Str $reversedNibbles = $filledUp.substr( 4 ) ~ $filledUp.substr( 0 , 4 ) ;
  say $reversedNibbles.parse-base( 2 ) ;
}
