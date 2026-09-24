use v6 ;

sub condition( $firstword , $secondword ) {
   my @firstletters = $firstword.comb ;
   my @selected = @firstletters.grep( {$secondword.index( $_ ) !~~ Int } ) ;
   return @selected.elems == @firstletters.elems ;
}

say "Enter some strings separated by whitespace!" ;
my $line = $*IN.get ;
my @strings = $line.words ;
my $maxi = 0 ;
for @strings.combinations( 2 ) -> $combi {
   if ( condition( $combi[0] , $combi[1] ) ) {
      my $val = $combi[0].chars * $combi[1].chars ;
      if ( $val > $maxi ) {
         $maxi = $val ;
      }
   }
}
say $maxi ;
