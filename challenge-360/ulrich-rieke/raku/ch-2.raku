use v6 ;

say "Enter a sentence!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my @sorted = @allWords.sort( {$^a.lc leg $^b.lc} ) ;
say @sorted.join( ' ' ) ;
