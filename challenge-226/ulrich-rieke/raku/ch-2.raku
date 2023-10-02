use v6 ;

sub mySubtr( $n is copy , $d is copy ) {
   $n -= $d ;
   if ( $n < 0 ) {
      $n = 0 ;
   }
   return $n ;
}

say "Enter some positive integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $rounds = 0 ;
while ( not (so 0 == @numbers.all )) {
   my $minimum = @numbers.grep( {$_ > 0} ).min ;
   @numbers = @numbers.map( { mySubtr( $_ , $minimum ) } ) ;
   $rounds++ ;
}
say $rounds ;
