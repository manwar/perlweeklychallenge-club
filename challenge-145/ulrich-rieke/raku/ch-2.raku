use v6 ;

sub isPalindrome( Str $word --> Bool ) {
  return $word eq $word.flip ;
}

sub contains( @strings , $substring ) {
  my $words = @strings.Set ;
  return $substring (elem) $words ;
}

sub MAIN( Str $s is copy ) {
  my @palindromes ;
  my $len = $s.chars ;
  for (0 .. $len - 1 ) -> $let {
      unless ( contains( @palindromes , $s.substr( $let , 1 ) ) ) {
    @palindromes.push( $s.substr( $let , 1 ) ) ;
      }
      my $diff = $len - $let ;
      while ( $diff > 1 ) {
    my $wordpart = $s.substr( $let , $diff ) ;
    if ( isPalindrome( $wordpart)  && not contains( @palindromes ,
          $wordpart)) {
        @palindromes.push( $wordpart ) ;
        last ;
    }
    else {
        $diff-- ;
    }
      }
  }
  say @palindromes.join( ' ' ) ;
}
