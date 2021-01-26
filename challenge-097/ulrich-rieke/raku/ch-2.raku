use v6 ;

sub isInputValid( Str $str , Int $n --> Bool ) {
  return $str.chars %% $n ;
}

#how many fields must be flipped to make all digits equal ?
#we zip the forward and reverse string and count how many pairs
#have different digits
sub countToMakeAllEqual( Str $str is copy --> Int ) {
  my %frequencies ;
  %frequencies<0> = 0 ;
  %frequencies<1> = 0 ;
  my $len = $str.chars ;
  for ( 0 .. $len - 1 ) -> $i {
      %frequencies{ $str.substr( $i , 1 ) }++ ;
  }
  if ( %frequencies<0> == $len or %frequencies<1> == $len ) {
      return 0 ;
  }
  elsif ( %frequencies<0> >= %frequencies<1> ) {
      return $len - %frequencies<0> ;
  }
  else {
      return $len - %frequencies<1> ;
  }
}

sub MAIN( Str $B is copy, Int $S ) {
  die "the length of $B should be a multiple of $S!" unless
      isInputValid( $B , $S ) ;
  my $len = $B.chars ;
  my $chunknumber = $len div $S ;
  my $chunklength = $len div $chunknumber ;
#we now transpose the chunks, that is the first letters of all chunks
#go into one word, the second letters into another and so on
#these transposed chunks should all consist of the same digits in the end
#word by word we sum up the flips that are necessary to make all digits
#equal
#first, we transpose
  my @chunks ;
  for (0 .. $chunknumber - 1 ) -> $i {
      @chunks.push( $B.substr( $i * $chunklength , $chunklength ) ) ;
  }
  my @words ;
  for (0 .. $chunklength - 1 ) -> $i {
      for (0 .. $chunknumber - 1 ) -> $j {
    @words[ $i ] ~= @chunks[ $j ].substr( $i , 1 ) ;
      }
  }
  say @words.map( { countToMakeAllEqual( $_ ) } ).sum ;
}
