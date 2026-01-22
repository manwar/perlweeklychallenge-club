use v6 ;

sub toNumber( @digits ) {
   return @digits[0] * 1000 + @digits[1] * 100 + @digits[2] * 10 + @digits[3] ;
}

sub createPair( $number is copy) {
   my @ascending ;
   while ( $number != 0 ) {
      @ascending.push( $number % 10 ) ;
      $number div= 10 ;
   }
   my $len = @ascending.elems ;
   if ( $len < 4 ) {
      for ($len..3 ) {
         @ascending.push( 0 ) ;
      }
   }
   if @ascending.grep( {$_ == @ascending[0]} ).elems == 4 {
      return (-1 , -1) ;
   }
   else {
      @ascending .= sort( {$^a <=> $^b} ) ;
      my @descending = @ascending.reverse ;
      return( toNumber( @descending ) , toNumber( @ascending ) ) ;
   }
}

say "Enter a positive number with 4 digits!" ;
my $line = $*IN.get ;
my $number = $line.Int ;
my @pair = createPair( $number ) ;
if ( @pair[0] == -1 ) {
   say -1 ;
}
else {
   my $count = 0 ;
   while ( $number != 6174 ) {
      my @pair = createPair( $number ) ;
      $count++ ;
      $number = @pair[0] - @pair[1] ;
   }
   say $count ;
}
