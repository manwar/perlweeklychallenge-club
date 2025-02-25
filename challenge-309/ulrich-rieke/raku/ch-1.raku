use v6 ;

say "Enter some integers in ascending order , separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my $min_diff = @numbers[1] - @numbers[0] ;
my $gap_end = @numbers[1] ;
for (2..$len - 1 ) -> $pos {
   my $currentdiff = @numbers[$pos] - @numbers[$pos - 1] ;
   if ( $currentdiff < $min_diff ) {
      $min_diff = $currentdiff ;
      $gap_end = @numbers[$pos] ;
   }
}
say $gap_end ;
