use v6 ;

sub findLength( $word , $start is copy) {
   my @balances ;
   my $balance = 1 ;
   @balances.push( $balance ) ;
   my $len = $word.chars ;
   $start++ ;
   while ( $start < $len ) {
      if ( $word.substr( $start , 1 ) eq "(" ) {
	 $balance++ ;
      }
      else {
	 $balance-- ;
      }
      if ( $balance < 0 ) {
	 last ;
      }
      @balances.push( $balance ) ;
      $start++ ;
   }
   my $howmany = @balances.grep( {$_ == 0} ).elems ;
   my $result ;
   if ( $howmany == 0 ) {
      $result = 0 ;
   }
   elsif ( $howmany == 1 ) {
      my $pos = 0 ;
      while ( @balances[$pos] != 0 ) {
	 $pos++ ;
      }
      $result = $pos + 1 ;
   }
   else {
      my $pos = $len - 1 ;
      while ( @balances[$pos] != 0 ) {
	 $pos-- ;
      }
      $result = $pos + 1 ;
   }
   return $result ;
}

say "Enter a string consisting of parentheses only!" ;
my $word = $*IN.get ;
my $len = $word.chars ;
my @lengths ;
for (0..$len - 1) -> $pos {
   if ( $word.substr( $pos , 1 ) eq "(" ) {
      @lengths.push(findLength( $word , $pos ) ) ;
   }
}
say @lengths.max ;
