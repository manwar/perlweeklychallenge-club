use v6 ;

say "Enter some strings separated by blanks!" ;
my $line = $*IN.get ;
my @firstWords = $line.words ;
say "Enter some more strings separated by blanks!" ;
$line = $*IN.get ;
my @secondWords = $line.words ;
my %firstFrequencies ;
my %secondFrequencies ;
@firstWords.map( {%firstFrequencies{$_}++} ) ;
@secondWords.map( {%secondFrequencies{$_}++} ) ;
say %firstFrequencies.keys.grep( {%firstFrequencies{$_} == 1  
      && (%secondFrequencies{$_}:exists) &&
      %secondFrequencies{$_} == 1 } ).elems ;

