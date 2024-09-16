use v6 ;

say "Enter an amount of money in cents!" ;
my $line = $*IN.get ;
my $amount = $line.Int ;
my $combis = 0 ;
for (0..$amount) -> $pennies {
   for (0..$amount div 5 ) -> $nickels {
      for (0..$amount div 10 ) -> $dimes {
	 for ( 0..$amount div 25) -> $quarters {
	    for ( 0..$amount div 50 ) -> $half-dollars {
	       if ($pennies + $nickels * 5 + $dimes * 10 + 
		     $quarters * 25 + $half-dollars * 50 == $amount ) {
		  $combis++ ;
	       }
	    }
	 }
      }
   }
}
say $combis ;
