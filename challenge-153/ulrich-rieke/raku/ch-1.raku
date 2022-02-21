use v6 ;

sub factorial( Int $n is copy ) {
  if ( $n == 0 ) {
      return 1 ;
  }
  else {
      return [*](1 .. $n) ;
  }
}

sub leftFactorial( Int $n --> Int ) {
  my $sum = 0 ;
  (0 .. $n - 1 ).map( { $sum += factorial( $_ ) } ) ;
  return $sum ;
}

my @leftFactorials ;
for (1 .. 10 ) -> $i {
  @leftFactorials.push( leftFactorial( $i ) ) ;
}
say @leftFactorials ;
