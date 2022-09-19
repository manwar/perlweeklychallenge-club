use v6 ;

say "Enter 2 numbers , separated by blanks!" ;
my $line = $*IN.get ;
my ($m , $n ) = $line.split( /\s+/ ).map( {.Int} ) ;
while ( $n > $m ) {
  say "The second number should be smaller than the first one! Re-enter!" ;
  $line = $*IN.get ;
  ($m , $n ) = $line.split( /\s+/ ).map( {.Int} ) ;
}
my @primes ;
for (2 .. $m) -> $i {
  if ( $i.is-prime ) {
      @primes.push( $i ) ;
  }
}
say @primes.combinations( $n ).grep( {@_.sum == $m} ) ;
