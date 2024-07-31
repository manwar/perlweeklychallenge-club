use v6 ;

say "Enter a word and a character , separated by a blank!" ;
my $line = $*IN.get ;
( my $word , my $needle) = $line.words ;
my $pos = $word.index( $needle ) ;
if ( $pos.defined   ) {
   my $firstPart = $word.substr( 0 , $pos + 1 ) ;
   my $sorted = $firstPart.comb.sort.join ;
   if ( $pos + 1 < $word.chars ) {
      say ( $sorted ~ $word.substr( $pos + 1 ) ) ;
   }
   else {
      say $sorted ;
   }
}
else {
   say $word ;
}
