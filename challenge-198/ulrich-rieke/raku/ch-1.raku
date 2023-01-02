use v6 ;

say "Enter some integers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ).map( {.Int} ) ;
if ( @numbers.elems < 2 ) {
  say 0 ;
}
else {
  my @sorted = @numbers.sort( { $^a <=> $^b } ) ;
  my $len = @sorted.elems ;
  my @differences ;
  for ( 0..$len - 2 ) -> $i {
      @differences.push( @sorted[ $i + 1 ] - @sorted[ $i ] ) ;
  }
  my $maxdiff = @differences.max ;
  my $count = 0 ;
  for @differences -> $diff {
      if ( $diff == $maxdiff ) {
    $count++ ;
      }
  }
  $count.say ;
}
