use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter a number!" ;
$line = $*IN.get ;
my $k = +$line ;
my $len = @numbers.elems ;
my $sum = 0 ;
for (0..$len - 1).combinations( 2 ) -> $combi {
   if ( @numbers[ $combi[0] ] == @numbers[ $combi[ 1 ] ] && ( $combi[0 ] *
	    $combi[ 1 ] ) %% $k ) {
      $sum++ ;
   }
}
$sum.say ;
