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

my @array = enterArray( ) ;
my $len = @array.elems ;
my $value = 0 ;
my $current = 0 ;
#we enter a loop and will forcibly leave it if we reached the last
#index of the array or if we can't move ahead because the value in the
#array is 0
while ( @array[ $current ] ) {
  $current += @array[ $current ] ;
  if ( $current == $len - 1 ) {
      $value = 1 ;
      last ;
  }
  if ( $current < $len - 1 and @array[ $current ] == 0 ) {
      last ;
  }
}
say $value ;
