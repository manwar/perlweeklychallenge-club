use v6 ;

sub findEnd( @numbers , $start ) {
  my $current = $start ;
  my $len = @numbers.elems ;
  $current = $start + 1 ;
  if ( $current == $len ) {
      return $start ;
  }
  else {
      while ( @numbers[ $current ] - @numbers[ $current - 1 ] == 1 ) {
    $current++ ;
    if ( $current == $len ) {
        last ;
    }
      }
      $current-- ;
      return $current ;
  }
}

say "Please enter a sorted array of integers, each unique!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ).map( {.Int} ) ;
my @sorted = @numbers.sort( {$^a <=> $^b} ) ;
while ( @sorted != @numbers || @numbers.elems != @numbers.Set.elems ) {
  say "Please enter a sorted array of unique numbers!" ;
  $line = $*IN.get ;
  @numbers = $line.split( /\s/ ).map( {.Int} ) ;
}
my $pos = 0 ;
my @subsequences ;
while ($pos < @numbers.elems - 1) {
  my $end = findEnd( @numbers , $pos ) ;
  if ( $end - $pos > 0 ) {
      @subsequences.push( [@numbers[ $pos ] , @numbers[ $end ] ] ) ;
  }
  $pos = $end + 1 ;
}
@subsequences.map( { "[" ~ $_.join( ',' ) ~ "]" } ).join( ',' ).say ;
