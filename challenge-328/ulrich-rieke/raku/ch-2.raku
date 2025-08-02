use v6 ;

say "Enter a word with English letters only!" ;
my $word = $*IN.get ;
my $solution ;
my $len = $word.chars ;
my $pos = 0 ;
while ( $pos < $len ) {
   $solution ~= $word.substr( $pos , 1 ) ;
   my $l = $solution.chars ;
   if ( $l > 1 ) {
      my $first = $solution.substr( $l - 2 , 1 ) ;
      my $second = $solution.substr( $l - 1 , 1 ) ;
      if (( $first.ord - $second.ord).abs == 32 ) {
	 $solution = $solution.substr( 0 , $l - 2 ) ;
      }
   }
   $pos++ ;
}
if ( $solution ) {
   say $solution ;
}
else {
   say "\"\"" ;
}
