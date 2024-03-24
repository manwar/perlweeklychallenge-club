use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter a start number!" ;
my $startn = $*IN.get ;
my $start = +$startn ;
my $found = $start ;
while ( so $found == @numbers.any ) {
   $found *= 2 ;
}
say $found ;
