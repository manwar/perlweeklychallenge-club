use v6 ;

sub position( @array , $elt ) {
   my $pos = 0 ;
   while ( @array[$pos] != $elt ) {
      $pos++ ;
   }
   return $pos ;
}

say "Enter some unique integers!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $mini = @numbers.min ;
my $maxi = @numbers.max ;
my $minpos = position( @numbers , $mini ) ;
my $maxpos = position( @numbers , $maxi ) ;
if ( $minpos < $maxpos ) {
   say ( $minpos + @numbers.elems - 1 - $maxpos ) ;
}
else { #one less, minimum and maximum move past each other!
   say ( $minpos + @numbers.elems - 1 - $maxpos - 1 ) ;
}
