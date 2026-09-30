use v6 ;

say "Enter a word consisting of English alphabetic characters only!" ;
my $word = $*IN.get ;
my $sum = [+] $word.comb.map( {.ord} ) ;
if ( $sum.is-prime ) {
   say 0 ;
}
else {
   my $upper_prime ;
   my $lower_prime ;
   my $current = $sum - 1 ;
   while not $current.is-prime {
      $current -= 1 ;
   }
   $lower_prime = $current ;
   $current = $sum + 1 ;
   while not $current.is-prime {
      $current += 1 ;
   }
   $upper_prime = $current ;
   say ( $upper_prime - $sum , $sum - $lower_prime ).min ;
}
