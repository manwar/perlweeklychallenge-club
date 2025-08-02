use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $positives = @numbers.grep( {$_ > 0} ).elems ;
my $negatives = @numbers.grep( {$_ < 0} ).elems ;
say max( $positives, $negatives ) ;
