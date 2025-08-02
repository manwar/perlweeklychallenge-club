use v6 ;

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
my @reversed = @strings.map( {$_.comb.reverse.join} ) ;
my $common = @strings.Set (&) @reversed.Set ;
say $common.keys.elems div 2 ;
