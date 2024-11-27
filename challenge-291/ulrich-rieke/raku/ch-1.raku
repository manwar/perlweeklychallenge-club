use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
if ( $len == 1 ) {
   say 0 ;
}
else {
   my $leftSum ;
   my $rightSum ;
   my $result = -1 ;
   for (0..$len - 1) -> $i {
      if ( $i == 0 ) {
	 $leftSum = 0 ;
      }
      else {
	 $leftSum = [+] @numbers[0..$i - 1] ;
      }
      if ( $i == $len - 1 ) {
	 $rightSum = 0 ;
      }
      else {
	 $rightSum = [+] @numbers[$i + 1..$len - 1] ;
      }
      if ( $leftSum == $rightSum ) {
	 $result = $i ;
	 last ;
      }
   }
   say $result ;
}
