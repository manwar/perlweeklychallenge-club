use v6 ;

sub MAIN( Int $m is copy , Int $n is copy ) {
  my @numbers = (~$m).comb.map( {.Int} ) ;
  my @digits = @numbers ;
  my $len = @numbers.elems ;
  if ( $len > 2 ) {
      for ( 2 .. $len - 1 ) -> $l {
    my @combis = @digits.combinations( $l ).map( {.join.Int} ) ;
    @combis.map( { @numbers.push( $_ ) } ) ;
      }
  }
  say @numbers.grep( { $_ %% $n } ).elems ;
}
