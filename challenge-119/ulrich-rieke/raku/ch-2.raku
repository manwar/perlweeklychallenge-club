use v6 ;

sub myCondition( Int $n is copy --> Bool ) {
  my $numberstring = ~$n ;
  if ( $numberstring ~~ /11/ ) {
      return False ;
  }
  my $ones = 0 ;
  my $twos = 0 ;
  my $threes = 0 ;
  for (0 .. $numberstring.chars - 1 ) -> $i {
      my $substr = $numberstring.substr( $i , 1 ) ;
      given $substr {
    when "1" { $ones++ }
    when "2" { $twos++ }
    when "3" { $threes++ }
      }
  }
  if ( $ones + $twos + $threes == $numberstring.chars ) {
      return True ;
  }
  return False ;
}

sub MAIN( Int $N is copy ) {
  my @numbers ;
  my $current = 1 ;
  @numbers.push( $current ) ;
  while ( @numbers.elems < $N ) {
      $current++ ;
      if ( myCondition( $current ) ) {
    @numbers.push( $current ) ;
      }
  }
  say @numbers[*-1] ;
}
