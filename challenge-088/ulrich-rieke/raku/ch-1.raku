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
my $product = [*] @array.map( {.Int} ) ;
my $len = @array.elems ;
my @M ;
for ( 0 .. $len - 1 ) -> $i {
  @M.push( $product / @array[ $i ] ) ;
}
@M.say ;
