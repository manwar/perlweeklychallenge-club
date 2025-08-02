use v6 ;

say "Enter some words, separated by blanks!" ;
my $line = $*IN.get ;
my @firstWords = $line.words ;
say "Enter some more words, separated by blanks!" ;
$line = $*IN.get ;
my @secondWords = $line.words ;
my %frequencies ;
@firstWords.map( {%frequencies{$_}++ } ) ;
@secondWords.map( {%frequencies{$_}++ } ) ;
my @rareWords = %frequencies.keys.grep( {%frequencies{$_} == 1 } ) ;
if ( @rareWords ) {
   print "(" ;
   say @rareWords.join( ',' ) ~ ")" ;
}
else {
   say "()" ;
}
