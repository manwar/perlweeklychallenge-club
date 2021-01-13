use v6 ;

sub MAIN( Int $n where 1 <= $n <= 5 ) {
  my @allCombos = ('a' , 'e' , 'i' , 'o' , 'u').combinations( $n ).List.map( {.join.Str} ) ;
  my @allCombinations  ;
  for @allCombos -> $elem {
      @allCombinations.push( $elem ) ;
      @allCombinations.push( flip( $elem ) ) ;
  }
  .say for @allCombinations.grep({$_ ~~ /a <[ei]>/ || $_ ~~ /ei/ ||
      /i <[aeou]>/ ||  /o <[au]>/ ||  /u <[oe]>/ }).sort ;
}
