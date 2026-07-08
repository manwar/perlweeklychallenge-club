use v6 ;

sub are_same( @first , @second ) {
   for (0..@first.elems - 1 ) -> $n {
      if ( @first[$n] != @second[$n] ) {
         return False ;
      }
   }
   return True ;
}

say "Enter a n x n matrix of integers from 1 to n!" ;
my @lines ;
my $line = $*IN.get ;
while ( $line ) {
   @lines.push( $line ) ;
   $line = $*IN.get ;
}
my @matrix ;
for @lines -> $row {
   @matrix.push( $row.words.map( {.Int} )) ;
}
my $len = @matrix.elems ;
my @comparison = (1..$len) ;
my $rows_ok ;
for (0..$len - 1 ) -> $r {
   my $row = @matrix[$r] ;
   my @row_elements ;
   for (0..$len - 1 ) -> $i {
      @row_elements.push( $row[$i] ) ;
   }
   @row_elements .= sort ;
   if ( not (are_same( @row_elements , @comparison) )) {
      $rows_ok = False ;
      last ;
   }
   $rows_ok = True ;
}
my $columns_ok ;
for (0..$len - 1) -> $col {
   my @column_numbers ;
   for (0..$len - 1 ) -> $r {
      @column_numbers.push( @matrix[$r][$col] ) ;
   }
   @column_numbers .= sort ;
   if ( not ( are_same( @column_numbers , @comparison) )) {
      $columns_ok = False ;
      last ;
   }
   $columns_ok = True ;
}
say ( $rows_ok && $columns_ok ) ;
