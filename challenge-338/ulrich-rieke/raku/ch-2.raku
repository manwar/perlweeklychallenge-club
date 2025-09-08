use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @firstnumbers = $line.words.map( {.Int} ) ;
say "Enter some more integers separated by whitespace!" ;
$line = $*IN.get ;
my @secondnumbers = $line.words.map( {.Int} ) ;
my @differences ;
for @firstnumbers -> $first {
   for @secondnumbers -> $second {
      @differences.push( abs( $first - $second ) ) ;
   }
}
say @differences.max ;
