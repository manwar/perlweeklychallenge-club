use v6 ;

sub enterIndices( Int $limit ) {
  my @indices ;
  my $line = prompt "Enter indices ( maximum is $limit , -1 to end ): " ;
  while ( $line != -1 ) {
      if ( $line <= $limit ) {
    @indices.push( $line ) ;
      }
      $line = prompt "Next number : " ;
  }
  return @indices ;
}

sub enterArray( ) {
  my @array ;
  my $line = prompt "Enter an integer ( -1 to end ) : " ;
  while ( $line != -1 ) {
      @array.push( $line ) ;
      $line = prompt "Next number : " ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my @indices = enterIndices( @array.elems - 1 ) ;
for @indices -> $index {
  say @array.rotate( $index ) ;
}
