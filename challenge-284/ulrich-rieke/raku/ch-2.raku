use v6 ;

say "Enter some integers, separated by blanks!" ;
my $line = $*IN.get ;
my @firstNumbers = $line.words.map( {.Int} ) ;
say "Enter some unique integers, which are a subset of the first integers!" ;
$line = $*IN.get ;
my @secondNumbers = $line.words.map( {.Int} ) ;
my %frequencies ;
@firstNumbers.map( {%frequencies{$_}++} ) ;
my @result ;
my $firstSet = @firstNumbers.Set ;
my $secondSet = @secondNumbers.Set ;
for (@secondNumbers) -> $n {
   for (1..%frequencies{$n} ) -> $times {
      @result.push( $n ) ;
   }
}
my @difference ;
for ( $firstSet (-) $secondSet ) -> $element {
   @difference.push( $element.key ) ;
}
@difference .= sort ;
for ( @difference ) -> $n {
   for (1..%frequencies{$n} ) {
      @result.push( $n ) ;
   }
}
say join( ',' , @result ) ;
