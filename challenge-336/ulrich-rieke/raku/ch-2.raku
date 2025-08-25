use v6 ;

say "Enter some integers and the character + , C or D separated by whitespace!" ;
my $line = $*IN.get ;
my @parts = $line.words ;
my @numbers ;
my $len = @parts.elems ;
my $pos = 0 ;
while ( $pos < $len  && @parts[$pos] ~~ /\d+/ ) {
   @numbers.push( +(@parts[$pos]) ) ;
   $pos++ ;
}
for ($pos..$len - 1 ) -> $i {
   if ( @parts[ $i ] ~~ /'C' | 'D' | '+' / ) {
      if ( @parts[ $i ] eq 'C' ) {
	 @numbers.pop( ) ;
      }
      if ( @parts[ $i ] eq 'D' ) {
	 @numbers.push( @numbers[*-1] * 2 ) ;
      }
      if ( @parts[ $i ] eq '+' ) {
	 my $l = @numbers.elems ;
	 @numbers.push( @numbers[$l - 2 ] + @numbers[ $l - 1 ] ) ;
      }
   }
   else { #we must be at a number 
      @numbers.push( +@parts[$i] ) ;
   }
}
say [+] @numbers ;
