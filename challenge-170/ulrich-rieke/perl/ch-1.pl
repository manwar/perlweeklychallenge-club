use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;

sub isPrime {
  my $number = shift ;
  my $stop = sqrt( $number ) ;
  for my $i ( 2 .. floor( $stop )) {
      if ( $number % $i == 0 ) {
        return 0 ;
      }
  }
  return 1 ;
}

my @primeNumbers = ( 1 ) ;
my @primorials ;
my $current = 2 ;
while ( scalar( @primeNumbers ) != 10 ) {
  if ( isPrime( $current ) ) {
      push @primeNumbers, $current ;
  }
  $current++ ;
}
push @primorials, 1 ;
for my $i (1 .. 9) {
  push @primorials , $primorials[-1] * $primeNumbers[ $i ] ;
}
say join( ', ' , @primorials ) ;
