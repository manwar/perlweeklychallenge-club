use v6 ;

say "Enter some positive integers and -1 separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @seen ;
my @answer ;
my $x = 0 ;
my $pos = 0 ;
my $len = @numbers.elems ;
while ( $pos < $len ) {
   my $num = @numbers[$pos] ;
   if ( $num > 0 ) {
      $x = 0 ;
      @seen.unshift( $num ) ;
   }
   else {
      if ( $x < @seen.elems ) {
	 @answer.push( @seen[$x] ) ;
      }
      else {
	 @answer.push( -1 ) ;
      }
      if ( $pos < $len - 1 && @numbers[$pos + 1] == -1 ) {
	 $x++ ;
      }
   }
   $pos++ ;
}
say '(' ~ @answer.join(',') ~ ')' ;
