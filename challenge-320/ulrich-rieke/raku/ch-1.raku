use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my $positives = @numbers.grep( {$_ > 0} ).elems ;
my $negatives = @numbers.grep( {$_ < 0} ).elems ;
if ( $positives != 0 || $negatives != 0 ) {
   say ($positives , $negatives).max ;
}
else {
   say 0 ;
}
