use v6 ;

say "Enter some numbers, separated by a blank!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @uniques = @numbers.unique ;
if ( @uniques.elems < 3 ) {
  say @uniques.max ;
}
else {
  my @sorted = @uniques.sort( { $^b <=> $^a } ) ;
  say @sorted[2] ;
}
