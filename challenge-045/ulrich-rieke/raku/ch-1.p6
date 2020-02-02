use v6 ;

sub convertString( Str $str is copy ) {
  $str ~~ s:g/\s+// ;
  my @strings = $str.comb.rotor( 8, :partial).map( {.join} ).Array ;
  my $encoded ;
  for (0..7) -> $i {
      for @strings -> $word {
    my $len = $word.chars ;
        $encoded ~= $word.substr( $i , 1 ) if $len > $i ;
      }
  }
  my $len = @strings.elems ;
#create as many full-length words as the last word in the columns is long
#then create as many full-length - 1-words as the difference of the length
#of the last word in the columns and 8 indicates
  my $lastwordlen = @strings[$len - 1].chars ;
  my @cycle ;
  for (1..$lastwordlen) {
      @cycle.push( $len ) ;
  }
  for ( 1..8 - $lastwordlen) {
      @cycle.push( $len - 1 ) ;
  }
  return $encoded.comb.rotor( @cycle ).map( {.join} ).Array ;
}

sub MAIN( Str $arg ) {
  say convertString( $arg ) ;
}
