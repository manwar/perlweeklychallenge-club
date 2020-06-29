use v6 ;

#We have to provide for the digit 0 with no letters attached
sub combineTwoStrings( Str $a , Str $b ) {
  my @combis ;
  if ( $a && $b ) {
      for $a.comb -> $firstletter {
    for $b.comb -> $secondletter {
        @combis.push( $firstletter ~ $secondletter ) ;
    }
      }
  }
  if ( $a && not $b ) {
      @combis.push( $a.comb ) ;
  }
  if ( not $a && $b ) {
      @combis.push( $b.comb ) ;
  }
  return @combis ;
}

#here too, we have to provide for '0' as a possible digit
sub combineStringWithArray( @array, Str $word ) {
  my @combis ;
  if ( $word ) {
      for $word.comb -> $letter {
    for @array -> $element {
        @combis.push( $element ~ $letter) ;
    }
      }
  }
  else {
      @combis = @array ;
  }
  return @combis ;
}

sub MAIN( Str $S ) {
  my %phone = "1" => "-,@" , "2" => "ABC" , "3" => "DEF" , "4" => "GHI",
      "5" => "JKL" , "6" => "MNO" , "7" => "PQRS" , "8" => "TUV" ,
      "9" => "WXYZ" , "0" => "" ;
  my @allCombis ;
  my $len = $S.chars ;
  if ( $len == 1 ) {
      @allCombis.push( %phone{ $S }.comb ) ;
  }
  if ( $len == 2 ) {
      @allCombis = combineTwoStrings( %phone{ $S.substr( 0 , 1 ) } ,
          %phone{ $S.substr( 1 , 1 ) } ) ;
  }
  if ( $len > 2 ) {
      my @letters = $S.comb ;
      @allCombis = combineTwoStrings( %phone{ @letters[ 0 ] } ,
        %phone{ @letters[ 1 ] } ) ;
      for (2..$len - 1) -> $i {
    @allCombis = combineStringWithArray( @allCombis ,
          %phone{ @letters[ $i ] } ) ;
      }
  }
  say @allCombis.map( {.lc} ) ;
}
