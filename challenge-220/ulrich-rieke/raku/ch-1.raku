use v6 ;

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words.map( {$_.lc} ) ;
my @wordSets = @words.map( { $_.comb.Set } ) ;
my $intersection = [(&)] @wordSets ;
say "(" ~ $intersection.keys.sort ~ ")" ;
