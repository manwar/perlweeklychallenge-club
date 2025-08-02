use v6 ;

say "Enter 2 strings separated by whitespace!" ;
my $line = $*IN.get ;
my @words = $line.words ;
if (@words[0].chars != @words[1].chars ) {
   say "false" ;
}
else {
#zip the letters of the 2 words and see whether there are only 2 pairs
#of unequal characters which are in reverse order of each other
   my @paired = @words[0].comb Z, @words[1].comb ;
   my @different = @paired.grep( {$_[0] ne $_[1]} ) ;
   say ( @different.elems == 2 && @different[0][0] eq @different[1][1] && 
	 @different[0][1] eq @different[1][0] ) ;
}
