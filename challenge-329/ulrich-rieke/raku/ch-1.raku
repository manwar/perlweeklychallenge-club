use v6 ;

say "Enter a string consisting of lowercase English letters and digits only!" ;
my $word = $*IN.get ;
my $substitute = $word ;
$substitute ~~ s:g/\D/ / ;
my @numbers = $substitute.words ;
my $uniques = @numbers.Set ;
my @solution ;
for @numbers -> $n {
   if ( $n (elem) $uniques ) {
      $uniques = $uniques (-) ($n).Set ;
      @solution.push( $n ) ;
   }
}
say @solution.join( ',' ) ;
