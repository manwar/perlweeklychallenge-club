use v6 ;

sub createPieceHash( Str $word, Int $chunklength ) {
  my %piecehash ;
  my $start = 0 ;
  my $len = $word.chars ;
  while ( $start + $chunklength < $len ) {
      %piecehash{ $word.substr( $start , $chunklength ) }++ ;
      $start += $chunklength ;
  }
  return %piecehash ;
}

sub MAIN( Int $N , Int $D ) {
  my $numberstring = sprintf( "%.15f" , $N / $D ) ;
  $numberstring ~~ /^(\d+) '.' (\d+) $/ ;
#we only look at the part after the decimal point
#we create a hash of all substrings of length 1 to (rest of string ) divided#by two to see if there is a recurring sequence. There is such a recurring
#sequence if the number of keys in the hash is only 1
#we repeat this operation for every starting point from 0 to 7 ( we
#limit the fraction part of the decimal string to 15 and allow the last
#digit to wobble )
#if the only recurring number is 0 we suppress it
  my $fractional = ~$1 ;
  my $whole =  ~$0 ;
  my %numberhash ;
  my $recurring ;
  for (0 .. 7 ) -> $start {
      my $rest = 14 - $start ;#position 15 after the decimal point wobbles
      for (1 .. $rest div 2 ) -> $chunk {
    %numberhash = createPieceHash( $fractional.substr( $start ) ,
          $chunk ) ;
    if ( %numberhash.keys.elems == 1 ) {
        $recurring = %numberhash.keys[0] ;
        last ;
    }
      }
  }
  if ( $recurring ) {
      my $pos = $fractional.index( $recurring ) ;
      if ( $recurring !~~ /^0+$/ ) {
    if ( $pos != 0 ) {
        $fractional = $fractional.substr( 0 , $pos ) ~ "(" ~
          $recurring ~ ")" ;
    }
    else {
        $fractional = "(" ~ $recurring ~ ")" ;
    }
      }
      else {
    $fractional = $fractional.substr(0 , $pos ) ;
      }
  }
  say ($whole ~ "." ~ $fractional) ;
}
