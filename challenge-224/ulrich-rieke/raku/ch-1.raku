use v6 ;

say "Enter a source string!" ;
my $source = $*IN.get ;
say "Enter a target string!" ;
my $target = $*IN.get ;
my %sourceHash ;
my %targetHash ;
my @targetletters = $target.comb ;
my @sourceletters = $source.comb ;
@targetletters.map( {%targetHash{$_}++} ) ;
@sourceletters.map( { %sourceHash{$_}++ } ) ;
my @selected = @targetletters.grep( {%sourceHash{$_}:exists &&
      %sourceHash{$_} >= %targetHash{$_} } ) ;
if ( @selected.elems == @targetletters.elems ) {
  say "true" ;
}
else {
  say "false" ;
}
