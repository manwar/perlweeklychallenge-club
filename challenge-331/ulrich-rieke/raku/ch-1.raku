say "Enter a string!" ;
my $word = $*IN.get ;
$word .= trim ;
my @words = $word.split( /\s+/ ) ;
say @words[*-1].chars ;
