use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @differences ;
for ( @numbers.combinations( 2 ) ) -> $combi {
   @differences.push( abs( $combi[0] - $combi[1] ) ) ;
}
say @differences.min ;
