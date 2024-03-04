use v6 ;

say "Enter some integers , separated by spaces!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter another integer!" ;
$line = $*IN.get ;
my $k = $line.Int ;
my $sum = 0 ;
my $len = @numbers.elems ;
for (0..$len - 1 ) -> $i {
   my @digits = $i.base( 2 ).comb.map( {.Int} )  ;
   if ( @digits.grep( { $_ == 1 } ).elems == $k ) {
      $sum += @numbers[ $i ] ;
   }
}
say $sum ;
