use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
if @numbers.elems < 3 {
   say @numbers.max ;
}
else {
   my $uniques = @numbers.Set ;
   my @sorted = $uniques.keys.sort ;
   my $len = @sorted.elems ;
   if ( $len < 3 ) {
      say @sorted.max ;
   }
   else {
      say @sorted[$len - 3] ;
   }
}
