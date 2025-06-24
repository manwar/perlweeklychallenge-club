use v6 ;

say "Enter some distinct integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @allCombis = @numbers.combinations: 2 ;
my $minimum = @allCombis.map( {abs( $_[0] - $_[1] )} ).min ;
my @selected = @allCombis.grep( {abs( $_[0] - $_[1] ) == $minimum } ) ; 
@selected.say ;
