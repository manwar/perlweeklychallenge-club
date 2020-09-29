use v6 ;

sub enterArray( ) {
  my @array ;
  say "Enter numbers ( 'e' to end ) " ;
  my $line = $*IN.get ;
  while ( $line ne 'e' ) {
      @array.push( +$line ) ;
      say "next number :" ;
      $line = $*IN.get ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my $len = @array.elems ;
my $candies = $len ;
for ( 0 .. $len - 1 ) -> $i {
  if ( $i < $len - 1 ) {
      if ( @array[ $i ] > @array[ $i + 1 ] ) {
    $candies++ ;
      }
  }
  if ( $i > 0 ) {
      if ( @array[ $i ] > @array[ $i - 1 ] ) {
    $candies++ ;
      }
  }
}
say $candies ;
