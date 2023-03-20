use v6 ;

sub findIndex( @array , $word ) {
  my $pos = 0 ;
  while ( @array[ $pos ] ne $word ) {
      $pos++ ;
  }
  return $pos ;
}

say "Enter some strings, separated by blanks!" ;
my $line = $*IN.get ;
my @firstWords = $line.words ;
my $firstSet = set( @firstWords ) ;
say "Enter some more strings, separated by blanks!" ;
$line = $*IN.get ;
my @secondWords = $line.words ;
my $secondSet = set( @secondWords ) ;
my $common = $firstSet (&) $secondSet ;
if ( $common.elems > 0 ) {
  my @indexlist ;
  for $common.keys -> $aWord {
      @indexlist.push( [$aWord , findIndex( @firstWords, $aWord ) + findIndex( @secondWords ,
          $aWord ) ] ) ;
  }
  my @sorted = @indexlist.sort( {$^a[1] <=> $^b[1] } ) ;
  my @allWords ;
  my $minimum = @sorted[0][1] ;
  for @sorted -> $pair {
      if ( $pair[ 1 ] == $minimum ) {
    @allWords.push( $pair[ 0 ] ) ;
      }
  }
  print "(" ;
  print join( ',' , @allWords ) ;
  say ")" ;
}
else {
  say "( ) " ;
}
