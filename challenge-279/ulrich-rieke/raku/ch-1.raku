use v6 ;

say "Enter some letters , separated by blanks!" ;
my $letters = $*IN.get ;
say "Enter some weights, separated by blanks!" ; 
my $weights = $*IN.get ;
my @letters_in = $letters.words ;
my @weights_in = $weights.words.map( {.Int} ) ;
my @pairs = @letters_in Z, @weights_in ;
my @sorted = @pairs.sort( *.[1] ).map( {$_[0]} ) ;
say @sorted.join ;
