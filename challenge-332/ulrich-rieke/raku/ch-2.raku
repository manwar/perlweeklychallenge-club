use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my %frequencies ;
$word.comb.map( {%frequencies{$_}++ } ) ;
say %frequencies.values.elems == %frequencies.values.grep( {$_ % 2 == 1} ).elems;
