use v6 ;

say "Enter m lines of n integers, separated by blanks on every line!" ;
say "Enter <return> to end!" ;
my @matrix ;
my $lucky = -1 ;
my $line = $*IN.get ;
while ( $line ) {
   my @numbers = $line.words.map( {.Int} ) ;
   @matrix.push( @numbers ) ;
   $line = $*IN.get ;
}
my @rowminima ;
my @colmaxima ;
my @columns ;
my $rownumber = @matrix.elems ;
my $colnumber = @matrix[0].elems ;
for (0..$colnumber - 1 ) -> $c {
   my @column ;
   for (0..$rownumber - 1 ) -> $r {
      @column.push( @matrix[$r][$c] ) ;
   }
   @columns.push( @column ) ;
}
for @matrix -> @row {
   @rowminima.push( @row.min ) ;
}
for @columns -> @column {
   @colmaxima.push( @column.max ) ;
}
my $common = @rowminima.Set (&) @colmaxima.Set ;
if $common.elems > 0 {
   $lucky = $common.keys ;
}
say $lucky ;
	    
