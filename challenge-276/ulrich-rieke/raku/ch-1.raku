use v6 ;

say "Enter some positive integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say @numbers.combinations( 2 ).grep( { $_.sum %% 24 } ).elems ;
