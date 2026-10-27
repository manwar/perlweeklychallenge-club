use v6 ;

sub reverseString( $word is copy ) {
   return $word.comb.reverse.join ;
}

sub toNumber( $binary ) {
   my $total = 0 ;
   my $multiplier = 2 ** ($binary.chars - 1) ;
   for ( $binary.comb ) -> $letter {
      $total += +$letter * $multiplier ;
      $multiplier div= 2 ;
   }
   return $total ;
}

sub convert( $number ) {
   my $binary = $number.base( 2 ) ;
   my $reversed = reverseString( $binary ) ;
   my $reflected = toNumber( $reversed ) ;
   return $reflected ;
}

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @sorted = @numbers.sort( { convert( $^a) <=> convert( $^b) || $^a <=>
      $^b }) ;
say '(' ~ @sorted.join( ',' ) ~ ')' ;
