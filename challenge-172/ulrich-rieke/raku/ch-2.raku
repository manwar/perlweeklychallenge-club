use v6 ;

sub findMedian( @array ) {# provided @array is sorted
  my $median ;
  my $size = @array.elems ;
  if ( $size == 2 ) {
      $median = (@array[0] + @array[1]) / 2 ;
  }
  if ( $size %% 2 && $size > 2 ) {
      $median = (@array[ ($size div 2) - 1 ] + @array[ $size div 2 ]) / 2 ;
  }
  if ( not ( $size %% 2 ) ) {
      $median = @array[ $size div 2 ] ;
  }
  return $median ;
}

say "Please enter an array of numbers, separated by blanks( more than 3 numbers! )" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s+/ ) ;
while ( @numbers.elems <= 3 ) {
  say "Please enter more than 3 numbers!" ;
  $line = $*IN.get ;
  @numbers = $line.split( /\s+/ ) ;
}
my @sorted = @numbers.sort( { $^a <=> $^b } ) ;
my $size = @sorted.elems ;
say "Minimum is { @sorted[0] }!" ;
say "Median is { findMedian( @sorted ) }!" ;
#I compute the first and third quartile by finding the median of the first
#and second half. If the number of elements in the array is odd there are
#different methods of computing the medians of the 2 halves. I arbitrarily
#choose the method of doubling the median and adding the median to both the
#lower and upper half of the array
print "First quartile is  " ;
if ( $size %% 2 ) {
  say "{ findMedian(@sorted[0 .. ($size div 2) - 1]) }!" ;
}
else {
  say "{ findMedian( @sorted[0 .. $size div 2]) }!" ;
}
print "Third quartile is " ;
if ( $size %% 2 ) {
  say "{ findMedian( @sorted[ $size div 2 .. $size - 1 ] ) }!" ;
}
else {
  say "{ findMedian( @sorted[ $size div 2 .. $size - 1 ] ) }!" ;
}
say "Maximum is @sorted[ *-1 ]!" ;
