use v6 ;

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
my @words = $line.words ;
say "Enter a check string!" ;
my $checkstr = $*IN.get ;
my $compare ;
for @words -> $word {
   $compare ~= $word.lc.substr( 0 , 1 ) ;
}
say ( $checkstr eq $compare ) ;
