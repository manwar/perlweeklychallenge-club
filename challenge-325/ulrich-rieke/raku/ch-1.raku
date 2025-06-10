use v6 ;

say "Enter some 0 and 1 separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $ones = 0 ;
my @groups ;
for @numbers -> $n {
   if ( $n == 1 ) {
      $ones++ ;
   }
   else {
      if ( $ones > 0 ) {
	 @groups.push( $ones ) ;
	 $ones = 0 ;
      }
   }
   if ( $ones > 0 ) {
      @groups.push( $ones ) ;
   }
}
if ( @groups ) {
   say @groups.max ;
}
else {
   say 0 ;
}
