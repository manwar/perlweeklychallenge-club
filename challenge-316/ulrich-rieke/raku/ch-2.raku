use v6 ;

say "Enter 2 words, the first one somewhat shorter than the second one!" ;
my $line = $*IN.get ;
my ($first , $second ) = $line.split( /\s/ ) ;
my $result = True ;
for ( $first.comb ) -> $aChar {
   my $found = $second.index( $aChar ) ;
   if ( $found.defined ) {
      if ( $found ~~ /\d+/ ) {
	 $second .= substr( $found ) ;
      }
   }
   else {
      $result = False ;
      last ;
   }
}
say $result ; 
