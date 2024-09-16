use v6 ;

say "Enter several numbers more than once , only one once!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my %frequencies ;
@numbers.map( {%frequencies{$_}++} ) ;
say @numbers.grep( {%frequencies{$_} == 1})[0] ;
