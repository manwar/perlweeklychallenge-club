use v6 ;

sub myRule( $aSeq ) {
  return $aSeq[0] < $aSeq[2] && $aSeq[2] < $aSeq[1] ;
}

say "Enter some integers , separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ).map( { .Int} ) ;
my @combis = @numbers.combinations: 3 ;
my @selected = @combis.grep( { myRule( $_ ) } ) ;
if ( @selected.elems > 0 ) {
  say @selected[ 0 ] ;
}
else {
  say "()" ;
}
