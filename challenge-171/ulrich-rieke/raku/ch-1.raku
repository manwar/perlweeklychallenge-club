use v6 ;

sub findDivisors( Int $n ) {
  my @divisors ;
  for ( 1 .. $n div 2 ) -> $i {
      if ( $n %% $i ) {
    @divisors.push( $i ) ;
      }
  }
  return @divisors ;
}

sub isAbundant( Int $n ) {
  my @divisors = findDivisors( $n ) ;
  return ([+] @divisors) > $n ;
}

my @oddAbundants ;
my $current = 3 ; #start at 3 because 1 is not a proper divisor of 1
while ( @oddAbundants.elems != 20 ) {
  if ( isAbundant( $current ) ) {
      @oddAbundants.push( $current ) ;
  }
  $current += 2 ;
}
say join( ',' , @oddAbundants ) ;
