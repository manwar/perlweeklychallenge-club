use v6 ;

say "Enter at least 3 integers in ascending order!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter a positive integer!" ;
my $diff = $*IN.get ;
my @indices = (0..@numbers.elems - 1 ) ;
my $result = 0 ;
my @combis = @indices.combinations( 3 ) ;
for @combis -> $combi {
   if ( @numbers[ $combi[ 1 ] ] - @numbers[ $combi[ 0 ] ] == $diff 
	 && @numbers[ $combi[ 2 ] ] - @numbers[ $combi[ 1 ] ] == $diff ) {
      $result++ ;
   }
}
say $result ;
