use v6 ;

say "Enter a term consisting of digits!" ;
my $term = $*IN.get ;
$term ~~ s:g/\s// ;
my $reversed = $term.flip ;
my $count = 1 ;#we start with 1 since we initiate payload with last charact.
my $payload = $reversed.substr( 0 , 1 ).Int ;
my @sums ;
for (1..$reversed.chars - 1 ) -> $pos {
   if ( $reversed.substr( $pos , 1 ) ~~ /<[0..9]>/ ) {
      my $number = +$reversed.substr( $pos , 1 ) ;
      if ( $count %% 2 ) {
	 @sums.push( $number ) ;
      }
      else {
	 my $sum = 2 * $number ;
	 if ( $sum > 9 ) {
	    @sums.push( digitsum( $sum ) ) ;
	 }
	 else {
	    @sums.push( $sum ) ;
	 }
      }
      $count++ ;
   }
}
my $totalSum = [+] @sums ;
say ($totalSum + $payload) %% 10 ;

sub digitsum( $number is copy ) {
   my $sum = 0 ;
   while ( $number != 0 ) {
      $sum += $number mod 10 ;
      $number div= 10 ;
   }
   return $sum ;
}


