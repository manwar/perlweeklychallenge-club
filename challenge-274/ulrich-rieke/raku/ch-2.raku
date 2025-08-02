use v6 ;

sub findNextStarts( $number , @schedule ) {
   my @startList ;
   for (0..@schedule.elems - 1) -> $i {
      my $start = @schedule[$i][1] ;
      while ( $start < $number ) {
	 $start += @schedule[$i][0] ;
      }
      @startList.push( ($i , $start ) ) ;
   }
   my @sorted = @startList.sort( {$^a[1] <=> $^b[1]} ) ;
   return @sorted ;
}

sub findNextArrivals( @schedule , @departures ) {
   my @arrivals ;
   for ( @departures ) -> $pair {
      @arrivals.push( $pair[1] + @schedule[$pair[0]][2] ) ;
   }
   return @arrivals ;
}

sub myCondition( $minute , @schedule ) {
   my @nextStarts = findNextStarts( $minute , @schedule ) ;
   my @arrivals = findNextArrivals( @schedule , @nextStarts ) ;
   if ( @nextStarts[0][1] != @nextStarts[1][1] && @arrivals[0] > @arrivals[1] ) {
      return True ;
   }
   else {
      return False ;
   }
}

say "Enter the schedule of some bus lines in 3 numbers each!" ;
my @lines ;
my $line = $*IN.get ;
while ( $line ) {
   @lines.push( $line ) ;
   $line = $*IN.get ;
}
my @schedule ;
for @lines -> $bus {
   my @subschedule = $bus.words.map( {.Int} ) ;
   @schedule.push( @subschedule ) ;
}
my @selected = (0..59).grep( {myCondition( $_ , @schedule )} ) ;
print '[' ;
print @selected.join( ',' ) ;
say ']' ;
