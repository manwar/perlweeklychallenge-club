use v6 ;

sub enterArray( ) {
  say "Enter an array, items separated by blanks!" ;
  my $line = $*IN.get ;
  my @array = $line.split( /\s+/ ) ;
  return @array ;
}

#after creating a combination of n numbers we look for the rest
sub findComplement( $subarray, @numbers ) {
  return (@numbers.Set (-) $subarray.Set).keys.Array ;
}

my @numbers = enterArray( ) ;
my $len = @numbers.elems ;
my $limit = $len div 2 ;#the length of one subset
my @allCombinations ;#for the subsets with the smallest difference of sums
my $difference = 100000 ;#high start value to enforce assignment of new value
if ( $len %% 2 ) {
  for @numbers.combinations( $limit ) -> $combi  {
      my @complement = findComplement( $combi, @numbers ) ;
      my $diff = abs( @complement.sum - $combi.sum ) ;
      if ( $diff < $difference ) {
    @allCombinations = ( ) ;#create space for new combinations
    @allCombinations.push( @complement , $combi ) ;
    $difference = $diff ;#and assign smaller difference
      }
  }
}
else {#logic as above
  for @numbers.combinations($limit ..$limit + 1) -> $combi  {
      my @complement = findComplement( $combi, @numbers ) ;
      my $diff = abs( @complement.sum - $combi.sum ) ;
      if ( $diff < $difference ) {
    @allCombinations = ( ) ;
    @allCombinations.push( @complement , $combi ) ;
    $difference = $diff ;
      }
  }
}
say "Subset 1 = (" ~  @allCombinations[0].sort( {$^a <=> $^b} ).join( ', ')
  ~ ")" ;
say  "Subset 2 = (" ~ @allCombinations[1].sort( {$^a <=> $^b} ).join(', ')
  ~ ")" ;
