use v6 ;
#find all numbers from 1 to n - 1 in the numerator and from 1 to n
#in the denominator where numerator and denominator are coprime to
#each other and order them in ascending order

subset Positive of Int where * > 0 ;

sub pairorder { ($^a[0] / $^a[1]) <=> ($^b[0] / $^b[1]) }

sub MAIN( Positive $n is copy ) {
  my @numerators = (1 .. $n - 1 ) ;
  my @denominators = (1 .. $n ) ;
  my @fractions ;
  @fractions.push( (0 , 1 ) ) ;
  for @numerators -> $num {
      for @denominators -> $denom {
    if ( ($num < $denom) && ($num lcm $denom ==
          $num * $denom) ) {
        @fractions.push( ($num , $denom) ) ;
    }
      }
  }
  my @sorted = @fractions.sort( &pairorder ) ;
  for @sorted -> $pair {
      print "$pair[0]/$pair[1], " ;
  }
  say "1/1" ;
}
