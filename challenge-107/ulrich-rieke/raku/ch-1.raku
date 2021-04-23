use v6 ;

sub isSelfDescriptive( Str $number --> Bool ) {
  my $len = $number.chars ;
  for (0 .. $len - 1 ) -> $pos {
      if ( $number.substr( $pos, 1 ).Int != myCount( $pos , $number ) ) {
    return False ;
      }
  }
  return True ;
}

sub myCount( Int $num, Str $numberstring --> Int ) {
  my $str = $num.Str ;
  my $len = $numberstring.chars ;
  my $count = 0 ;
  my $found = $numberstring.index( $str , 0 ) ;
  while ( defined $found ) {
      $count++ ;
      if ( $found + 1 < $len ) {
    $found = $numberstring.index( $str , $found + 1 ) ;
      }
      else {
    last ;
      }
  }
  return $count ;
}

sub addOne( Int $base , Str $number --> Str ) {
  if ( $base != 10 ) {
      my $num = $number.parse-base( $base );
      return (++$num).base( $base ) ;
  }
  else {
      my $num = +$number ;
      return (++$num).Str ;
  }
}

say "For which base do you want to generate the first self-descriptive numbers ?" ;
say "It should be a number greater than or equal 4!" ;
my $base = $*IN.get.Int ;
while ( $base < 4 ) {
  say "The base should at least be 4! Re-enter base!" ;
  $base = $*IN.get.Int ;
}
my @selfDescriptives ;
my $current = "1" ~ ('0' x ( $base - 1 ) ) ;
repeat {
  $current = addOne( $base , $current ) ;
  if ( isSelfDescriptive( $current )) {
      @selfDescriptives.push( $current ) ;
  }
  if ( $current.chars > $base ) { #there may not be 3 self descriptive numbers in a
#given base
    $base++ ;
    $current = "1" ~ ('0' x ( $base - 1 ) ) ;
  }
} until ( @selfDescriptives.elems == 3 ) ;
say @selfDescriptives ;
