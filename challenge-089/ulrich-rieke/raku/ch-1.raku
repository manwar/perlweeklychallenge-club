use v6 ;

sub MAIN( Int $N ) {
  my @gcds ;
  for (1..$N).combinations( 2 ) -> $combi {
      @gcds.push( $combi[0] gcd $combi[1] ) ;
  }
  my $sum = [+] @gcds ;
  say $sum ;
}
