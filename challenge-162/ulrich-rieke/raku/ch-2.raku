use v6 ;

sub createGridWord( Str $seedphrase is copy ) {
  my %lettercount ;
  my @alphabet = ('a' ..'i').Array ;
  my @secondPart = ('k' .. 'z').Array ;
  for @secondPart -> $let {
      @alphabet.push( $let ) ;
  }
  for @alphabet -> $let {
      %lettercount{ $let } = 0 ;
  }
  my @gridLetters ;
  $seedphrase ~~ s:g/\s// ;
  for ( $seedphrase.comb ) -> $let {
      if ( %lettercount{ $let } == 0 ) {
    @gridLetters.push( $let ) ;
    %lettercount{ $let } = 1 ;
      }
  }
  for @alphabet -> $let {
      if ( %lettercount{ $let } == 0 ) {
    @gridLetters.push( $let ) ;
      }
  }
  return @gridLetters.join( ) ;
}

#which row in the grid is the number in ?
sub findRow( Int $n is copy --> Int ) {
  return ($n - ( $n % 5 )) div 5 ;
}

#which column in the grid is the number in?
sub findColumn( Int $n --> Int ) {
  return $n % 5 ;
}

#rule if both letters of a pair are on the same row
sub encodeOnSameRow( Str $keyPhrase , Str $letter --> Str ) {
  my $pos = $keyPhrase.index( $letter ) ;
  if ( findRow( $pos + 1 ) == findRow( $pos ) ) {
      return $keyPhrase.substr( $pos + 1 , 1 ) ;
  }
  else {
      return $keyPhrase.substr( $pos - 4 , 1 ) ;
  }
}

#rule if both letters of a pair are on the same column
sub encodeOnSameColumn( Str $keyPhrase , Str $letter --> Str ) {
  my $pos = $keyPhrase.index( $letter ) ;
  if ( $pos + 5 > 25 ) {
      return $keyPhrase.substr( $pos % 5 , 1 ) ;
  }
  else {
      return $keyPhrase.substr( $pos + 5 , 1 ) ;
  }
}

#the rule if a rectangle in the keyword grid is taken into account
sub encodeOnRectangle( Str $keyPhrase , Str $pair --> Str ) {
  my Str $encrypted ;
  my Int $pos1 = $keyPhrase.index( $pair.substr( 0 , 1 )) ;
  my Int $pos2 = $keyPhrase.index( $pair.substr( 1 , 1 )) ;
  my Int $row1 = findRow( $pos1 ) ;
  my Int $row2 = findRow( $pos2 ) ;
  my Int $col1 = findColumn( $pos1 ) ;
  my Int $col2 = findColumn( $pos2 ) ;
  $encrypted ~= $keyPhrase.substr( $row1 * 5 + $col2 , 1 ) ;
  $encrypted ~= $keyPhrase.substr( $row2 * 5 + $col1 , 1 ) ;
  return $encrypted ;
}

#the following functions provide the return way of encoding
sub decodeOnSameRow( Str $keyPhrase , Str $letter --> Str ) {
  my Int $pos = $keyPhrase.index( $letter ) ;
  my Str $decrypted ;
  if ( findRow( $pos - 1 ) == findRow( $pos ) ) {
      $decrypted = $keyPhrase.substr( $pos - 1 , 1 ) ;
  }
  else {
      $decrypted = $keyPhrase.substr( $pos + 4 , 1 ) ;
  }
  return $decrypted ;
}

sub decodeOnSameColumn( Str $keyPhrase , Str $letter --> Str ) {
  my Str $decrypted ;
  my Int $pos = $keyPhrase.index( $letter ) ;
  if ( $pos - 5 < 0 ) {
      $decrypted = $keyPhrase.substr( 20 + findColumn( $pos ) , 1 ) ;
  }
  else {
      $decrypted = $keyPhrase.substr( $pos - 5 , 1 ) ;
  }
  return $decrypted ;
}

sub decodeOnRectangle( Str $keyPhrase , Str $encoded --> Str ) {
  my Str $decrypted ;
  my Int $pos1 = $keyPhrase.index( $encoded.substr( 0 , 1 ) ) ;
  my Int $pos2 = $keyPhrase.index( $encoded.substr( 1 , 1 )) ;
  my Int $row1 = findRow( $pos1 ) ;
  my Int $row2 = findRow( $pos2 ) ;
  my Int $col1 = findColumn( $pos1 ) ;
  my Int $col2 = findColumn( $pos2 ) ;
  $decrypted ~= $keyPhrase.substr( $row1 * 5 + $col2 , 1 ) ;
  $decrypted ~= $keyPhrase.substr( $row2 * 5 + $col1 , 1 ) ;
  return $decrypted ;
}

#kind of composition of the above encoding functions
sub encrypt( Str $keyPhrase , Str $toBeEncrypted is copy --> Str ) {
  my Str $encrypted ;
  my $len = $toBeEncrypted.chars ;
  if ( not ( $len %% 2 ) ) {
      $toBeEncrypted ~= "x" ;
  }
  my @pairs = $toBeEncrypted.comb.rotor( 2 ) ;
  for @pairs -> $pair {
      my Int $pos1 = $keyPhrase.index( $pair[0] ) ;
      my Int $pos2 = $keyPhrase.index( $pair[1] ) ;
      if ( findRow( $pos1 ) == findRow( $pos2 ) ) {
    $encrypted ~= encodeOnSameRow( $keyPhrase , $pair[0] )  ;
    $encrypted ~= encodeOnSameRow( $keyPhrase, $pair[1]) ;
      }
      elsif ( findColumn( $pos1 ) == findColumn( $pos2 ) ) {
    $encrypted ~= encodeOnSameColumn( $keyPhrase, $pair[ 0 ]  ) ;
    $encrypted ~= encodeOnSameColumn( $keyPhrase , $pair[1]) ;
      }
      else {
    $encrypted ~= encodeOnRectangle( $keyPhrase , $pair[0] ~ $pair[1] ) ;
      }
  }
  return $encrypted ;
}

#composition of the above decoding functions
sub decrypt( Str $keyPhrase, Str $toBeDecrypted --> Str ) {
  my Str $decrypted ;
  my @pairs = $toBeDecrypted.comb.rotor( 2 ) ;
  for @pairs -> $pair {
      my Int $pos1 = $keyPhrase.index( $pair[0] ) ;
      my Int $pos2 = $keyPhrase.index( $pair[1] ) ;
      if ( findColumn( $pos1 ) == findColumn( $pos2 ) ) {
    $decrypted ~= decodeOnSameColumn( $keyPhrase , $pair[0] ) ;
    $decrypted ~= decodeOnSameColumn( $keyPhrase , $pair[1] ) ;
      }
      elsif ( findRow( $pos1 ) == findRow( $pos2 )) {
    $decrypted ~= decodeOnSameRow( $keyPhrase , $pair[0] ) ;
    $decrypted ~= decodeOnSameRow( $keyPhrase , $pair[1] ) ;
      }
      else {
    $decrypted ~= decodeOnRectangle( $keyPhrase , $pair[0] ~ $pair[1] ) ;
      }
  }
  return $decrypted ;
}

#if two neighbouring letters are the same we intercalate an 'x'
sub intercalate( Str $word is copy --> Str ) {
  my @letters = $word.comb ;
  my Str $intercalated ;
  my $len = $word.chars ;
  for (0 .. $len - 2) -> $i {
      if ( $word.substr( $i , 1 ) eq $word.substr( $i + 1 , 1 )) {
    $intercalated ~= $word.substr( $i , 1 ) ;
    $intercalated ~= 'x' ;
      }
      else {
    $intercalated ~= $word.substr( $i , 1 ) ;
      }
  }
  return $intercalated ;
}

say "Please enter a key phrase:" ;
my Str $keyPhrase = $*IN.get ;
$keyPhrase ~~ s:g/'j'/'i'/ ;#j is taken for an i
my Str $gridWord = createGridWord( $keyPhrase ) ;
say "Please enter a string you want to encode:" ;
my Str $forEncryption = $*IN.get ;
$forEncryption ~~ s:g/'j'/'i'/ ;
$forEncryption ~~ s:g/\s// ;
my Int $len = $forEncryption.chars ;
if ( not ( $len %% 2 ) ) {
  $forEncryption ~= "x" ;
}
if ( $forEncryption ~~ /(.)$0/ ) {
  $forEncryption = intercalate( $forEncryption ) ;
}
say "The encrypted string is " ~ (encrypt( $gridWord , $forEncryption )) ~ " !" ;
say "Enter another key phrase!" ;
$keyPhrase = $*IN.get ;
$gridWord = createGridWord( $keyPhrase ) ;
say "Please enter a string you want to decode:" ;
my Str $forDecryption = $*IN.get ;
say "The decrypted string is " ~ (decrypt( $gridWord , $forDecryption )) ~ " !" ;
