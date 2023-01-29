use v6 ;

sub MAIN( Int $num ) {
#add every number from 1 to $num as many times as it can be added to be
#summed up to $num , then find combinations from them
  my @allNumbers ;
  for (1..$num) -> $n {
    @allNumbers.push( |($n xx ( $num div $n )) ) ;
  }
  my $allHeaps = 2 ; # $num times one pennies and one time $num pennies
  my @allCombis ; #combinations of 1 to $num , consisting of 2 to $num - 1 numb.
  for (2..$num - 1 ) -> $n {
    for @allNumbers.combinations( $n ) -> $combi {
    @allCombis.push( $combi ) ;
    }
  }
#every sequence, created by the combinations method , is to be included
#only once. For this purpose, we join the digits in each sequence , use that
#as 'unique' criterion and take the sequences apart again
my @candidates = @allCombis.map( {.join} ).unique.map( {.comb} ) ; ;
$allHeaps +=  @candidates.grep( {$_.sum == $num} ).elems ;
say $allHeaps ;
}
