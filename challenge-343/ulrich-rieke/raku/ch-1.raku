use v6 ;
#find minimum absolute value
say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @differences = @numbers.map( {.abs} ) ;
say @differences.min ;
