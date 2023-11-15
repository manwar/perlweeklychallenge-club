use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $sum = 0 ;
my $len = @numbers.elems ;
for (0..$len - 2 ) -> $i {
   for ( $i + 1 .. $len - 1 ) -> $j {
      if ( @numbers[ $i ] > 2 * @numbers[ $j ] ) {
	 $sum++ ;
      }
   }
}
$sum.say ;
