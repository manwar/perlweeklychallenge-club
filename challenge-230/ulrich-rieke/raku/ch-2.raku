use v6 ;

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
say "Enter a prefix!" ;
my $prefix = $*IN.get ;
my @words = $line.words ;
say @words.grep( { $_ ~~ /^$prefix/ } ).elems ;
