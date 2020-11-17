use v6 ;

sub enterArray( ) {
  my @array ;
  say "Enter positive numbers, -1 to end!" ;
  my $num = $*IN.get ;
  while ( +$num != -1 ) {
      @array.push( $num ) ;
      $num = $*IN.get ;
  }
  return @array ;
}

sub MAIN( Int $A ) {
  my $output = 0 ;
  my @array = enterArray( ) ;
  my @sorted = @array.sort( { $^b <=> $^a } ) ;
  for @sorted.combinations( 2 ) -> $combi {
      if ( $combi[ 0 ] - $combi[1] == $A ) {
    $output = 1 ;
    last ;
      }
  }
  say $output ;
}
