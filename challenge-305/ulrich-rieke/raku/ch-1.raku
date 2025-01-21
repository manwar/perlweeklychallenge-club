use v6 ;

sub to_decimals( @binaries ) {
   my @decimals ;
   my $len = @binaries.elems ;
   my $numberstring ;
   for (0..$len - 1 ) -> $i {
      $numberstring ~= ~@binaries[ $i ] ;
      my $number = $numberstring.parse-base( 2 ) ;
      @decimals.push( $number ) ;
   }
   return @decimals ;
}

say "Enter some binary digits separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
my @decimals = to_decimals( @numbers ) ;
my @truth_values = @decimals.map( {.is-prime} ) ;
say '(' ~ join( ',' , @truth_values ) ~ ')' ;
