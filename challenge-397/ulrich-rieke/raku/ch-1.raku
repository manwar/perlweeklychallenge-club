use v6 ;

sub contains( @array , $element ) {
   for @array -> $elt {
      if ( $elt == $element ) {
         return True ;
      }
   }
   return False ;
}

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $average = ([+] @numbers) / @numbers.elems ;
my $ceil = $average.ceiling ;
my $current ;
if ( $ceil == $average ) {
   $current = $average + 1 ;
}
else {
   if ( $ceil < 0.0 ) {
      $current = $ceil + 1 ;
   }
   else {
      $current = $ceil ;
   }
}
while ( $current <= 0 ) {
   $current++ ;
}
while ( contains( @numbers , $current)) {
   $current++ ;
}
$current.say ;
