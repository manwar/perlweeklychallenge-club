use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my %frequencies ;
@numbers.map( {%frequencies{$_}++} ) ;
my @selected = @numbers.grep( {%frequencies{$_} == $_} ) ;
if ( @selected.elems > 1 ) {
   say @selected.max ;
}
elsif ( @selected.elems == 1) {
   say @selected[0] ;
}
else {
   say -1 ;
}
