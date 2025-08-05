use v6 ;

say "Enter some integers separated by whitespace!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @after_doubling ;
for @numbers -> $n {
   if ( $n == 0 ) {
      @after_doubling.push( 0 ) ;
      @after_doubling.push( 0 ) ;
   }
   else {
      @after_doubling.push( $n ) ;
   }
}
my $len = @numbers.elems ;
say @after_doubling[0..$len - 1].join( ',' ) ;
