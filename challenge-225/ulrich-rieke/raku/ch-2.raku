use v6 ;

sub find_left_array( @array ) {
  my @left_array ;
  my $len = @array.elems ;
  my $limit = $len div 2 ;
  @left_array.push( 0 ) ;
  my $left_sum = 0 ;
  for (0..$limit) -> $i {
      $left_sum += @array[ $i ] ;
      @left_array.push( $left_sum ) ;
  }
  return @left_array ;
}

sub find_right_array( @array ) {
  my @right_array ;
  my $len = @array.elems ;
  my $left_limit ;
  if ( $len % 2 == 1 ) {
      $left_limit = $len div 2 ;
  }
  else {
      $left_limit = ( $len div 2 ) - 1 ;
  }
  my $right_sum = 0 ;
  for ($left_limit..$len - 1) -> $i {
      $right_sum += @array[ $i ] ;
  }
  @right_array.push( $right_sum ) ;
  for ($left_limit..$len - 1 ) -> $i {
      $right_sum -= @array[ $i ] ;
      @right_array.push( $right_sum ) ;
  }
  @right_array.push( 0 ) ;
  return @right_array ;
}

sub my_op( $num1 , $num2 ) {
  return abs( $num1 - $num2 ) ;
}

say "Find some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int } ) ;
my $len = @numbers.elems ;
if ( $len == 1 ) {
  say "(0)" ;
}
else {
  my @result ;
  my @left_array = find_left_array( @numbers ) ;
  my @right_array = find_right_array( @numbers ) ;
  say "(" ~ join( "," , zip( @left_array, @right_array , :with( &my_op ) ))
      ~ ")" ;
}
