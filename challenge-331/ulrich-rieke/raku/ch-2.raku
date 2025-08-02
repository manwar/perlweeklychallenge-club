use v6 ;

sub condition( $firstWord , $secondWord ) {
   my %firstHash ;
   my %secondHash ;
   $firstWord.comb.map( {%firstHash{$_}++} ) ;
   $secondWord.comb.map( {%secondHash{$_}++} ) ;
   return %firstHash.keys == %secondHash.keys ;
}

sub isSwapped( $aPair ) {
   my $firstPair = $aPair[0] ;
   my $secondPair = $aPair[1] ;
   return $firstPair[ 0 ] eq $secondPair[1] && $firstPair[1] eq $secondPair[0] ;
}

say "Enter two words separated by a space!" ;
my $line = $*IN.get ;
my @parts = $line.words ;
if ( @parts[0].chars == @parts[1].chars && condition( @parts[0] , @parts[1] ) ) {
   my $first = @parts[0] ;
   my $second = @parts[1] ;
   my @pairs = $first.comb Z, $second.comb ;
   my @neighbours = @pairs.rotor( 2 => -1 ) ;
   if ( @neighbours.grep( {isSwapped( $_ )} ).elems == 1 ) {
      say "true" ;
   }
   else {
      say "false" ;
   }
}
else {
   say "false" ;
}
