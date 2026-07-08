use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
if ( @numbers.elems < 3 ) {
   say 0 ;
}
else {
   my @selected ;
   for @numbers -> $num {
      if (so $num > @numbers.any && so $num < @numbers.any ) {
         @selected.push( $num ) ;
      }
   }
   say @selected.elems ;
}
