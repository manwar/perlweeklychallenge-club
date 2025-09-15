use v6 ;

say "Please enter some height differences as integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @heights = (0) ;
my $currentHeight = 0 ;
for @numbers -> $n {
   $currentHeight += $n ;
   @heights.push( $currentHeight ) ;
}
say @heights.max ;
