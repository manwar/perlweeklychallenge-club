use v6 ;

say "Enter an integer!" ;
my $line = $*IN.get ;
my $number = $line.Int ;
say (2..$number).grep( {.is-prime} ).elems ;
