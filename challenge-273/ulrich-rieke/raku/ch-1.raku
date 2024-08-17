use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
say "Enter a character!" ;
my $needle = $*IN.get ;
my $count = $word.comb.grep( {$_ eq $needle} ).elems ;
say (( $count / $word.chars ) * 100).round ;
