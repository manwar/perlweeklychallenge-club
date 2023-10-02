use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @sorted = @numbers.sort( {$^a <=> $^b } ) ;
my $samepos = 0 ;
for ( 0..@numbers.elems - 1 ) -> $i {
  if ( @numbers[ $i ] == @sorted[ $i ] ) {
      $samepos++ ;
  }
}
say $samepos ;
