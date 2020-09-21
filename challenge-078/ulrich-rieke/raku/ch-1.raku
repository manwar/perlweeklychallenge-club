use v6 ;

sub enterArray( ) {
  my @array ;
  my $line = prompt "Enter an integer ( -1 to end ) : " ;
  while ( $line != -1 ) {
      @array.push( $line ) ;
      $line = prompt "Next number : " ;
  }
  return @array.unique ;
}

my @array = enterArray( ) ;
my @leaders ;
my $len = @array.elems ;
for (0..$len - 2 ) -> $i {
  if ( @array[ $i ] > max( @array[ $i + 1 ..$len - 1] ) ) {
      @leaders.push( @array[ $i ] ) ;
  }
}
@leaders.push( @array[ *-1]) ;
say @leaders ;
