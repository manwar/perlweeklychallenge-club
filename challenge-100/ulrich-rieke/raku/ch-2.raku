----------------------------------------------------------------------------------------
use v6 ;

sub enterArray( ) {
  say "enter array rows, separated by blank space, e to end data entry!" ;
  say "rows should grow by 1 element per line!" ;
  my @array ;
  my $line = $*IN.get ;
  while ( $line ne 'e' ) {
      my @elements = $line.split( /\s+/ ).map( { .Int } ) ;
      @array.push( [|@elements] ) ;
      $line = $*IN.get ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my $len = @array.elems ;
my $sum = 0 ;
my $currentIndex = 0 ;
for (0 .. $len - 1 ) -> $i {
  my $row = @array[ $i ] ;
  if ( $row.elems == 1 ) {
      $sum += $row[ 0 ] ;
  }
  else {
      $sum += $row[ $currentIndex , $currentIndex + 1].min ;
      if ( $row[ $currentIndex] > $row[ $currentIndex + 1] ) {
    $currentIndex++ ;
      }
  }
}
$sum.say ;
