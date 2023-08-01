use v6 ;

sub findIndex( @array , $needle ) {
   my $pos = 0 ;
   while ( @array[ $pos ] != $needle ) {
      $pos++ ;
   }
   return $pos ;
}

say "Enter some unique integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $rounds = 0 ;
while ( @numbers.elems > 0 ) {
   my $mini = @numbers.min( ) ;
   my $pos = findIndex( @numbers , $mini ) ;
   my $num = @numbers.shift ;
   if ( $pos == 0 ) {
   }
   else {
      @numbers.push( $num ) ;
   }
   $rounds++ ;
}
say $rounds ;

