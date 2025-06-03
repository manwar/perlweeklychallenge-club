use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter number of rows and columns!" ;
$line = $*IN.get ;
my ( $rows , $columns ) = $line.words.map( {.Int} ) ;
if ( $rows * $columns != @numbers.elems ) {
   say "Error! The product of rows and columns must equal the number of elements!" ;
}
else {
   my @array ;
   my $pos = 0 ;
   for (0..$rows - 1 ) -> $r {
      my @currentRow ;
      for (0..$columns - 1 ) -> $c {
	 @currentRow.push( @numbers[$pos] ) ;
	 $pos++ ;
      }
      @array.push( @currentRow ) ;
   }
   print "( " ;
   for ( @array ) -> $a {
      print '[' ~ $a.join( ',' ) ~ "] " ;
   }
   say ")" ;
}
