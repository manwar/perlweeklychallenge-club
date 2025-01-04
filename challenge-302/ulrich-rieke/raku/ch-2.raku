use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my @partial_sums ;
my $current = @numbers[0] + @numbers[1] ;
@partial_sums.push( $current ) ;
if ( $len > 2 ) {
   for ( 2..$len - 1) -> $i {
      $current += @numbers[ $i ] ;
      @partial_sums.push( $current ) ;
   }
}
my $mini = @partial_sums.min ;
my $result = 1 - $mini ;
if ( $result <= 0 ) {
   say 1 ;
}
else {
   say $result ;
}
