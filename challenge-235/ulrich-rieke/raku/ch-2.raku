use v6 ;

say "Enter some integers, separated by spaces!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @result ;
for @numbers -> $n {
   if ( $n != 0 ) {
      @result.push( $n ) ;
   }
   else {
      for (1 , 2 ) {
	 @result.push( 0 ) ;
      }
   }
}
my $len = @numbers.elems ;
say "(" ~ @result[0..$len - 1 ].join( ',' ) ~ ")" ;
