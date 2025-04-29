use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @firstnumbers = $line.words.map( {.Int} ) ;
say "Enter some more integers separated by blanks!" ;
$line = $*IN.get ;
my @secondnumbers = $line.words.map( {.Int} ) ;
my $firstset = @firstnumbers.Set ;
my $secondset = @secondnumbers.Set ;
my $common = $firstset (&) $secondset ;
if ( $common.elems  > 0 ) {
   say $common.keys.min ;
}
else {
   say -1 ;
}
