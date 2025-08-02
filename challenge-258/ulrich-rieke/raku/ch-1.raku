use v6 ;

say "Enter some integers, separated by spaces!" ;
my $line = $*IN.get ;
my @numbers = $line.words ;
say @numbers.grep( {$_.chars %% 2}  ).elems ;
