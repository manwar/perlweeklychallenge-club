use v6 ;

say "Enter 2 ^ n many integers, where n is a positive integer!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $last_was_min = False ; #did we determine the minimum last time ?
while ( @numbers.elems > 1 ) {
   my @pairs = @numbers.rotor( 2 ) ;
   my @intermediate ; #for the minima and maxima of neighbouring pairs
   for @pairs -> $pair {
      if ( $last_was_min ) { #we must find the maximum
	 @intermediate.push( $pair.max ) ;
	 $last_was_min = False ; #toggle the boolean value
      }
      else {
	 @intermediate.push( $pair.min ) ;
	 $last_was_min = True ;
      }
   }
   @numbers = @intermediate ;
   @intermediate = ( ) ;
}
say @numbers[0] ;
