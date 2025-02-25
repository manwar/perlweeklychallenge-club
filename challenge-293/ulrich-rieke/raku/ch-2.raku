use v6 ;

sub find_slope( @firstNums, @secondNums ) {
   return (@secondNums[1] - @firstNums[1]) / ( @secondNums[0] - 
	 @firstNums[0] ) ;
}

sub areEqual( @firstNums, @secondNums ) {
   return @firstNums[0] == @secondNums[0] && @firstNums[1] == 
      @secondNums[1] ;
}

my @points ;
for (1..3) {
   say "Enter 2 integers as coordinates of a point!" ;
   my $line = $*IN.get ;
   my @numbers = $line.words.map( {.Int} ) ;
   @points.push( @numbers ) ;
}
my $firstCondition = not areEqual( @points[0] , @points[1] ) && 
 ( not areEqual( @points[1] , @points[2] ) ) ;
 my $secondCondition = find_slope( @points[0] , @points[1] ) != 
  find_slope( @points[1] , @points[2] ) ;
say ( $firstCondition && $secondCondition ) ;  

