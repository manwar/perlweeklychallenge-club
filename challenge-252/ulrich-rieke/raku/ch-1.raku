use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $sum = 0 ;
my $len = @numbers.elems ;
for ( 0..$len - 1 ) -> $i {
   if ( $len %% ( $i + 1 )) {
      $sum += @numbers[$i]** 2 ;
   }
}
say $sum ;
