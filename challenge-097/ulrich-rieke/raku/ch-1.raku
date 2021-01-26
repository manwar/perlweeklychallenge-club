use v6 ;

sub MAIN( Str $S, Int $N ) {
  my @alphabet = ('A' .. 'Z') ;
  my @ciphers = @alphabet.rotate( -($N mod 26)) ;
  my %correlations ;
  %correlations{ ' ' } = ' ' ;
  for (0 .. 25 ) -> $i {
      %correlations{ @alphabet[ $i ] } = @ciphers[ $i ] ;
  }
  say $S.comb.map( { %correlations{ $_ } } ).join ;
}
