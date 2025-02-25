use v6 ;

#find squares of numbers starting from every row and column of the matrix
sub make_squares( @aMatrix , $row , $column ) {
   my @all_squares ;
   my $matrixlen = @aMatrix.elems ;
   my $rowlen = @aMatrix[0].elems ;
   my $mini ;
   if ( $matrixlen - $row < $rowlen - $column ) {
      $mini = $matrixlen - $row ;
   }
   else {
      $mini = $rowlen - $column ;
   }
   for (0..$mini - 1 ) -> $i {
      my @small_square ;
      if ( $i == 0 ) {
	 @small_square.push( @aMatrix[$row][$column] ) ;
	 @all_squares.push( @small_square ) ;
      }
      else {
	 for ($row..$row + $i ) -> $r {
	    for ($column..$column + $i ) -> $c {
	       @small_square.push( @aMatrix[$r][$c] ) ;
            }
	 }
	 @all_squares.push( @small_square ) ;
      }
   }
   return @all_squares ;
}

sub find_square_sum( @matrix , $row , $col ) {
   my @all_squares = make_squares( @matrix , $row , $col ) ;
   my @sizes ;
   my $sum ;
   for @all_squares -> @subsquare {
      if so 1 == @subsquare.all {
	  $sum = [+] @subsquare ;
      }
      else {
	 $sum = 0 ;
      }
      @sizes.push( $sum ) ;
   }
   if ( @sizes ) {
      return @sizes.max ;
   }
   else {
      return 0 ;
   }
}

say "Enter some equal numbers of 0 and 1 separated by whitespace!" ;
say "Enter <return> to end!" ;
my @matrix ;
my $line = $*IN.get ;
while ( $line ) {
   my @current = $line.words.map( {.Int} ) ;
   @matrix.push( @current ) ;
   $line = $*IN.get ;
}
my $matrixlen = @matrix.elems ;
my $rowlen = @matrix[0].elems ;
my @squaresizes ;
for (0..$matrixlen - 1 ) -> $r {
   for (0..$rowlen - 1 ) -> $c {
      my $squaresum = find_square_sum( @matrix , $r , $c ) ;
      @squaresizes.push( $squaresum ) ;
   }
}
if ( @squaresizes ) {
   say @squaresizes.max ;
}
else {
   say 0 ;
}
