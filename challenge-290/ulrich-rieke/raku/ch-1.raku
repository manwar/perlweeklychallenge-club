use v6 ;

say "Enter some integers , separated by blanks!" ;
my $numberline = $*IN.get ;
my @numbers = $numberline.words.map( {.Int} ) ;
my $len = @numbers.elems ;
my $result = False ;
for (0..$len - 2) -> $outer {
   if ( @numbers[$outer] > 1 ) {
      for ( $outer + 1 .. $len - 1 ) -> $inner {
	 if ( @numbers[$outer] == 2 * @numbers[$inner] ) {
	    $result = True ;
	    last ;
	 }
      }
   }
}
say $result ;
