use v6 ;

say "Enter some words!" ;
my $line = $*IN.get ;
my @firstwords = $line.words ;
say "Enter some more words!" ;
$line = $*IN.get ;
my @secondwords = $line.words ;
my %frequencies ;
for @firstwords -> $word {
   %frequencies{$word}++ ;
}
for @secondwords -> $word {
   %frequencies{$word}++ ;
}
my @selected = %frequencies.keys.grep( {%frequencies{$_} == 1 } ) ;
say '(' ~ @selected.join( ',' ) ~ ')' ;
