use v6 ;

say "Enter some integers , separated by blanks!" ;
my $line = $*IN.get ;
my @firstNumbers = $line.words.map( {.Int} ) ;
say "Enter some more integers, separated by blanks!" ;
$line = $*IN.get ;
my @secondNumbers = $line.words.map( {.Int} ) ;
my $firstSet = @firstNumbers.Set ;
my $secondSet = @secondNumbers.Set ;
my $firstDiff = $firstSet (-) $secondSet ;
my $secondDiff = $secondSet (-) $firstSet ;
print "((" ;
if ( $firstDiff ) {
   print $firstDiff.keys.sort ;
}
if ( $secondDiff ) {
   say ") , (" ~ $secondDiff.keys.sort ~ "))" ;
}
else {
   say "))" ;
}
