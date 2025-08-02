use v6 ;

say "Enter a long integer!" ;
my $number = $*IN.get ;
my @triplets = $number.comb.rotor( 3 => -2 ) ;
my @selected = @triplets.grep( { $_[0] eq $_[1] && $_[1] eq $_[2] } ) ;
if ( @selected.elems == 0 ) {
   say -1 ;
}
else {
   say @selected[0][0] ;
}
