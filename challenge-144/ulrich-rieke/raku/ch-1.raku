use v6 ;

my @semiprimes ;
my @primes = (2 .. 100).grep( { .is-prime} ) ;
my @combis = @primes.combinations( 2 ).map( { $_[0] * $_[1] } ) ;
for @primes -> $prime {
  @combis.push( $prime * $prime ) ;
}
@combis .= sort ;
my @solution = @combis.grep( { $_ <= 100 } ) ;
say @solution ;
