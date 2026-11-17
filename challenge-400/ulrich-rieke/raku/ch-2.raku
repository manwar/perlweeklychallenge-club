use v6 ;

sub stringDifference( $firstGenome , $secondGenome ) {
   my $differences = 0 ;
   for (0..$firstGenome.chars - 1) -> $pos {
      if ( $firstGenome.substr( $pos , 1 ) ne $secondGenome.substr( $pos , 1 )) {
         $differences++ ;
      }
   }
   return $differences ;
}

sub contains( @array , $element ) {
   for @array -> $elt {
      if $elt eq $element {
         return True ;
      }
   }
   return False ;
}

say "Enter a start genome!" ;
my $start = $*IN.get ;
say "Enter an end genome of equal length as start!" ;
my $end = $*IN.get ;
say "Enter a gene bank of genomes of equal length!" ;
my $bank = $*IN.get ;
my @genes = $bank.words ;
if ( $start eq $end ) {
   say 0 ;
}
elsif ( not (contains( @genes , $end ))) {
   say -1 ;
}
else {
   my @differences = @genes.map( {stringDifference( $start , $_ )} ) ;
   my $mutations = stringDifference( $start , $end ) ;
   my @sorted = @differences.sort ;
   my $result = True ;
   for (1..$mutations) -> $current {
     if (not contains( @sorted , $current )) {
        $result = False ;
        last ;
     }
   }
   if ( $result ) {
      say $mutations ;
   }
   else {
      say -1 ;
  }
}





