use v6 ;

say "Enter a string with several words separated by space!" ;
my $line = $*IN.get ;
my @words = $line.words ;
my @result ;
for @words -> $w {
   if ( $w.chars < 3 ) {
      @result.push( $w.lc ) ;
   }
   else {
      @result.push( $w.tclc ) ;
   }
}
say @result.join( ' ' ) ;
