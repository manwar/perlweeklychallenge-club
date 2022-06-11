use v6 ;

my @primeNumbers ;
my $n = 2 ;
while ( @primeNumbers.elems != 11 ) {
  if ( $n.is-prime ) {
      @primeNumbers.push( $n ) ;
  }
  $n++ ;
}
my @primorials ;
@primorials.push( 2 ) ;
for (1 .. 10 ) -> $i {
  @primorials.push( [*] @primeNumbers[0 .. $i] ) ;
}
my @fortunates ;
my $current = 0 ;
while ( @fortunates.unique.sort.elems != 8 ) {
  my $num = @primorials[ $current ] ;
  my $m = 2 ;
  my $sum = $num + $m ;
  while ( not $sum.is-prime ) {
      $m++ ;
      $sum = $num + $m ;
  }
  $current++ ;
  @fortunates.push( $m ) ;
}
say @fortunates.unique.sort.join( ',' ) ;
