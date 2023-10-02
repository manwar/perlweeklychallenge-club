use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @sorted = @numbers.map( { $_ ** 2 } ).sort( { $^a <=> $^b } ) ;
say "(" ~ @sorted.join( ',' ) ~ ")" ;
