use v6 ;

say "Enter some positive integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
if ( @numbers.elems < 4 ) {
   say "false" ;
}
elsif ( @numbers.elems == 4 ) {
   my @selected = @numbers.grep( {$_ == @numbers[0]} ) ;
   if ( @selected.elems != @numbers.elems ) {
      say "false" ;
   }
   else {
      say "true" ;
   }
}
else {
   my $sum = [+] @numbers ;
   if ( not ( $sum %% 4 ) ) {
      say "false" ;
   }
   else {
      my $maxi = @numbers.max ;
      my %frequencies ;
      @numbers.map( {%frequencies{$_}++} ) ;
      my $maxsum = (4 - %frequencies{$maxi}) * $maxi ;
      my $restsum = 0 ;
      for (%frequencies.keys) -> $elt {
	 if ( $elt != $maxi ) {
	    $restsum += $elt * %frequencies{$elt} ;
	 }
      }
      if ( $restsum == $maxsum ) {
	 say "true" ;
      }
      else {
	 say "false" ;
      }
   }
}


