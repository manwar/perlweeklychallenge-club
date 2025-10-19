use v6 ;

sub mySorter( @firstPair , @secondPair ) {
   my $firstOnes = @firstPair[1].grep( {$_ == 1} ).elems ;
   my $secondOnes = @secondPair[1].grep( {$_ == 1 } ).elems ;
   if ( $firstOnes != $secondOnes ) {
      if ( $firstOnes < $secondOnes ) {
	 return Order::Less ;
      }
      else {
	 return Order::More ;
      }
   }
   else {
      if ( @firstPair[1][@secondPair[0]] == 0 ) {
	 return Order::Less ;
      }
      else {
	 return Order::More ;
      }
   }
}

say "Enter some numbers 0 and 1 , <enter> to end!" ;
my $line = $*IN.get ;
my @matrix ;
my $counter = 0 ;
while ( $line ) {
   my @numbers = $line.words.map( {.Int} ) ;
   my @row ;
   @row.push( $counter ) ;
   @row.push( @numbers ) ;
   @matrix.push( @row ) ;
   $counter++ ;
   say "Enter some numbers 0 and 1 , <enter> to end!" ;
   $line = $*IN.get ;
}
my @sorted = @matrix.sort( &mySorter ) ;
say "Team " ~ @sorted[*-1][0] ;
