use v6 ;

#is every first number of a pair not greater than its right neighbour ?
#to check that, we look at non-overlapping pairs of two
sub is_valid( $permu ) {
  my $len = $permu.elems ;
  my $i = 0 ;
  while ( $i != $len ) {
      if ($permu[ $i ] > $permu[ $i + 1 ] ) {
    return False ;
      }
      else {
    $i += 2 ; #pairs must not overlap
      }
  }
  return True ;
}

say "Please enter an even number of integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $len = @numbers.elems ;
unless ( $len %% 2 ) {
  say "Please enter an even number of integers!" ;
  $line = $*IN.get ;
  @numbers = $line.words.map( {.Int} ) ;
  $len = @numbers.elems ;
}
my @permus = (0..$len - 1).permutations ;#all permutations of positions
my @valids = @permus.grep( {is_valid( $_ )} ) ;#these are valid
my $maximum = 0 ;
for @valids -> $v {
  my @minima ;
  my $i = 0 ;
  while ( $i != $len ) {
      @minima.push( (@numbers[ $v[ $i ] ] , @numbers[ $v[$i + 1]]).min ) ;
      $i += 2 ;
  }
  my $sum = @minima.sum ;
  if ( $sum > $maximum ) {
      $maximum = $sum ;
  }
}
say $maximum ;
