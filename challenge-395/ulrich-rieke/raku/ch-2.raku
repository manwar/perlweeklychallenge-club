use v6 ;

sub condition( $sequence ) {
   my $len = $sequence[0].chars ;
   my @recombined ;
   for (0..$len - 1 ) -> $i {
      my $combined ;
      for slip($sequence) -> $w {
         $combined ~= $w.substr( $i , 1 ) ;
      }
      @recombined.push( $combined ) ;
   }
   for ( 0..$len - 1 ) -> $i {
      if ( $sequence[$i] ne @recombined[$i] ) {
         return False ;
      }
   }
   return True ;
}

say "Enter some words with equal length!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
my $l = @strings[0].chars ;
my @suitable_combis = @strings.combinations.grep( {$_.elems == $l} ) ;
my @permus ;
for @suitable_combis -> $combi {
   my @subarray ;
   for slip( $combi ) -> $w {
      @subarray.push( $w ) ;
   }
   my @subpermus = @subarray.permutations ;
   @permus.push( @subpermus ) ;
}
my @solution ;
for @permus -> @subpermu {
   for @subpermu -> $seq {
      if ( condition( $seq ) ) {
         @solution.push( $seq ) ;
      }
   }
}
say @solution ;
