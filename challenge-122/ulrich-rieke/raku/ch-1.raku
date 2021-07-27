use v6 ;

sub enterArray( ) {
  say "Enter an array, items separated by blanks!" ;
  my $line = $*IN.get ;
  my @array = $line.split( /\s+/ ) ;
  return @array ;
}

my @array = enterArray( ) ;
my @averages ;
my $len = @array.elems ;
my $sum = 0 ;
for (0 .. $len - 1 ) -> $i {
  $sum += @array[ $i ] ;
  my $av = $sum / ( $i + 1 ) ;
  @averages.push( $av ) ;
}
say @averages.join( ", " ) ;
