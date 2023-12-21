use v6 ;

say "Enter a matrix with some lines each consisting the same number of integers!" ;
say "Enter <return> to end entry!" ;
my $line = $*IN.get ;
my @matrix ;
while ( $line ) {
   @matrix.push( $line.words.map( {.Int} )) ;
   $line = $*IN.get ;
}
my $matrix_len = @matrix.elems ;
my $row_len = @matrix[0].elems ;
my @result ;
for ( 0..$matrix_len - 2 ) -> $row {
   my @resultline ;
   for ( 0..$row_len - 2 ) -> $col {
      my $sum = @matrix[ $row ][ $col ] + @matrix[$row][$col + 1 ] +
	 @matrix[ $row + 1 ][ $col ] + @matrix[ $row + 1 ][$col + 1] ;
      @resultline.push( $sum ) ;
   }
   @result.push( @resultline ) ;
}
say "(" ;
for @result -> @columns {
   say ( "  (" ~ @columns.join( ',' ) ~ ")" ) ;
}
say ")" ;


