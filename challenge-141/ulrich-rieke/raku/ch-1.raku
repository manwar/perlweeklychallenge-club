use v6 ;

sub findDivisors( Int $n ) {
  return ( 1 .. $n).grep( { $n %% $_ } ) ;
}

my @wanted ;
my Int $current = 1 ;
while ( @wanted.elems < 10 ) {
  my @divisors = findDivisors( $current ) ;
  if ( @divisors.elems == 8 ) {
      @wanted.push( $current ) ;
  }
  $current++ ;
}
say @wanted ;
