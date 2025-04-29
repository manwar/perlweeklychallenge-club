use v6 ;

say "Enter some words separated by blanks!" ;
my $line = $*IN.get ;
my @allWords = $line.words ;
my $vowels = rx/<[a e i o u A E I O U]>/ ;
my @selected = @allWords.grep( { $_ ~~ /^$vowels/ || $_ ~~ /$vowels$/} ) ;
say @selected.elems ;
