use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my $sum = 0 ;
for ( @numbers ) -> $num {
   $sum += $num ** 2 * $num ;
}
for (2..$len ) -> $n {
   my @combis = @numbers.combinations( $n ) ;
   for @combis -> $combi {
      my $maximum = $combi.max ;
      my $minimum = $combi.min ;
      $sum += $maximum ** 2 * $minimum ;
   }
}
$sum.say ;
