use v6 ;

#finds all possible combinations of numbers of the given length in the
#array, by using the combinations method and by adding repetitions of
#the numbers in the array
sub createCombinations( @array, $l ) {
  my @numbers ;
  my $len = @array.elems ;
  for (0..$len - 1 ) -> $i {
      @numbers.push( (@array[ $i ] xx $l).join ) ;
  }
  my @combinations = @array.combinations( $l ).map( {.join} ) ;
  my @reversed = @combinations.map( {.flip} ) ;
  @numbers.push( @combinations.shift) while @combinations ;
  @numbers.push( @reversed.shift ) while @reversed ;
  return @numbers.grep( {$_.chars == $l} ) ;
}

sub MAIN( *@ARGV ) {
  my $len = @ARGV.elems ;
  my @array = @ARGV[0..$len - 3 ] ;
  my $x = @ARGV[ *-2].Int ;
  my $y = @ARGV[ *-1 ].Int ;
  if ( $x > @ARGV[*-1].chars ) {
      say "cannot solve this! The smallest {$x}-digit number is greater than $y!" ;
      exit 1 ;
  }
  my @numbercombinations = createCombinations( @array, $x ) ;
  my @valid = @numbercombinations.grep( {$_ !~~ /^0+/ } ) ;
  my @solution = @valid.map( {.Int}).grep( {$_ < $y} ).sort ;
  say @solution ;
}
