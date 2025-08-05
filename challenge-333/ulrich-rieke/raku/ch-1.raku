use v6 ;

say "Enter 3 coordinate pairs in brackets!" ;
my $line = $*IN.get ;
my @pairs ;
my @parts = $line.split( /\] ',' \s+\[/ ) ;
for @parts -> $pair {
   if ($pair ~~ /(\d+)\s* ',' \s* (\d+) / ) {
      my $numberpair = [+$0 , +$1] ;
      @pairs.push( $numberpair ) ;
   }
}
say on_straight_line( @pairs ) ;

sub on_straight_line( @numbers ) {
   if (@numbers[0][0] == @numbers[1][0] && @numbers[1][0] == @numbers[2][0] ||
      @numbers[0][1] == @numbers[1][1] && @numbers[1][1] == @numbers[2][1] ) {
      return True ;
   }
   else {
      my $slope_one = (@numbers[1][1] - @numbers[0][1]) / (@numbers[1][0] - 
	    @numbers[0][0] ) ;
      my $slope_two = (@numbers[2][1] - @numbers[1][1] ) / (@numbers[2][0] -
	    @numbers[1][0] ) ;
      return $slope_one == $slope_two ;
   }
}
