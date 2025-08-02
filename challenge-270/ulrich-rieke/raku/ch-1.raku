use v6 ;

my @matrix ;
say "Enter a binary matrix of 0 and 1 separated by blanks!" ;
say "Enter <return> to end entry!" ;
my $line = $*IN.get ;
while ( $line.chars > 0 ) {
   @matrix.push( $line.words.map( {.Int} ) ) ;
   $line = $*IN.get ;
}
#the given task corresponds to the following : find all rows and columns
#with only one 1 in them ( their row or column sum is 1 ), the smaller of
#the row and column total with this requirement is our solution
my $validRows = 0 ;
for (0..@matrix.elems - 1 ) -> $row {
   my $seq = @matrix[ $row ] ;
   my $sum = 0 ;
   for ( 0..$seq.elems - 1 ) -> $elt {
      $sum += $seq[$elt] ;
   }
   if ( $sum == 1 ) {
      $validRows++ ;
   }
}
my $validColumns = 0 ;
for (0..@matrix[0].elems - 1) -> $col {
   my @transposed ;
   for (0..@matrix.elems - 1 ) -> $row {
      my $elt = @matrix[$row][$col] ;
      @transposed.push( $elt ) ;
   }
   if ( @transposed.sum == 1 ) {
      $validColumns++ ;
   }
}
say min( $validRows , $validColumns ) ;
