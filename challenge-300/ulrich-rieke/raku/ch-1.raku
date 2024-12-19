use v6 ;

sub conditions( $permu ) {
   my $len = $permu.elems ;
   for (1..$len) -> $i {
      if ( not ( $permu[$i - 1] %% $i || $i %% $permu[$i - 1] ) ) {
	 return False ;
      }
   }
   return True ;
}

say "Enter a positive integer!" ;
my $line = $*IN.get ;
my $number = +$line ;
my @permus = (1..$number).permutations ;
say @permus.grep( {conditions( $_ ) } ).elems ;
