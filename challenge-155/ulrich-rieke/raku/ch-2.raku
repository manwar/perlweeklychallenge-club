use v6 ;

sub count( $el, @array ) {
  return @array.grep( {$_ == $el} ).elems ;
}

my @fibonacci = (0 , 1 ) ;
while ( @fibonacci.elems != 500 ) {
  @fibonacci.push( @fibonacci[*-1] + @fibonacci[*-2] ) ;
}
my @thirdPisanos = @fibonacci.map( { $_ % 3 } ) ;
#in what follows I determine the equality of array slices by subtracting
#corresponding elements from each other.
#In doing that I stop when the first 2 identical slices are found.
#In all honesty I am not sure whether this applies to all Pisano numbers
#and one would have to apply one of the general Fibonacci generating
#functions to do that
my @differences ;
my $n = 2 ;
@differences.push( @thirdPisanos[0] - @thirdPisanos[2] ) ;
@differences.push( @thirdPisanos[1] - @thirdPisanos[3] ) ;
while ( count( 0 , @differences) != $n ) {
  $n++ ;
  @differences = ( ) ;
  for (0 .. $n - 1 ) -> $i {
      @differences.push( @thirdPisanos[$i] - @thirdPisanos[ $i + $n] ) ;
  }
}
say $n ;
