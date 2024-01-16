use v6 ;

sub is_valid( $permu , @theIs , @theDs ) {
   for @theIs -> $pos {
      if ( $permu[$pos] >= $permu[ $pos + 1 ] ) {
	 return False ;
      }
   }
   for @theDs -> $pos {
      if ( $permu[ $pos ] <= $permu[ $pos + 1 ] ) {
	 return False ;
      }
   }
   return True ;
}

say "Enter a string consisting of capital D and I only!" ;
my $line = $*IN.get ;
my @is ;
my @ds ;
my $len = $line.chars ;
for (0..$len - 1 ) -> $pos {
   if ( $line.substr( $pos , 1 ) eq "I" ) {
      @is.push( $pos ) ;
   }
   else {
      @ds.push( $pos ) ;
   }
}
for (0..$len).permutations -> $permu {
   if ( is_valid( $permu , @is , @ds ) ) {
      say ( "(" ~ join( ',' , $permu ) ~ ")" ) ;
      last ;
   }
}

