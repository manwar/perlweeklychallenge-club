use v6 ;
#to make the examples fit , I assume that in finding the left subarray
#you go to index given by the length of the array , integer-divided by 2 ,
#- 1 if the length of the entire array is an odd number, otherwise to index
#length divided by 2
sub find_left_array( @array ) {
  my @left_array ;
  my $len = @array.elems ;
  my $limit ;
  if ( $len % 2 == 1 ) {
      $limit = $len div 2 + 1 ;
  }
  else {
      $limit = $len div 2 ;
  }
  @left_array.push( 0 ) ;
  my $left_sum = 0 ;
  for (0..$limit) -> $i {
      $left_sum += @array[ $i ] ;
      @left_array.push( $left_sum ) ;
  }
  return @left_array ;
}

#to make the examples fit , I assume that the right subarray is gathered
#from elements start at index ( length integer-divided by 2 , - 1 )
sub find_right_array( @array ) {
  my @right_array ;
  my $len = @array.elems ;
  my $left_limit = $len div 2 - 1 ;
  my $right_sum = 0 ;
  for ($left_limit..$len - 1) -> $i {
      $right_sum += @array[ $i ] ;
  }
  @right_array.push( $right_sum ) ;
  for ($left_limit..$len - 1 ) -> $i {
      $right_sum -= @array[ $i ] ;
      @right_array.push( $right_sum ) ;
  }
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
