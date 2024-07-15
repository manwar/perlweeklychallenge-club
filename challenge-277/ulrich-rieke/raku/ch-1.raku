use v6 ;

say "Enter some words, separated by blanks!" ;
my $firstLine = $*IN.get ;
my @firstWords = $firstLine.words ;
say "Enter more words, separated by blanks!" ;
my $secondLine = $*IN.get ;
my @secondWords = $secondLine.words ;
my $common = @firstWords.Set (&) @secondWords.Set ;
my %firstFreq ;
my %secondFreq ;
@firstWords.map( {%firstFreq{$_}++} ) ;
@secondWords.map( {%secondFreq{$_}++} ) ;
say $common.keys.grep( {%firstFreq{$_} == 1 && %secondFreq{$_} == 1 } ).
elems ;
