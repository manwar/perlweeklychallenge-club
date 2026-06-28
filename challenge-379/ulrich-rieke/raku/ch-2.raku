use v6 ;

#we convert any given number in base 10 to a number in the given base
#to find out whether it is an Armstrong number we have to discard all
#those numbers that, after conversion , contain a letter
sub isArmstrong( $number , $base ) {
   my $numberInBase = $number.base( $base ) ;
   if ( not ($numberInBase ~~ /^\d+$/ )) {
      return False ;
   }
   else {
      my @digits = $numberInBase.comb.map( { $_.Int } ) ;
      my $len = @digits.elems ;
      return ([+] @digits.map( {$_ ** $len } )) == $number ;
   }
}

say "Enter , separated by space , a base and a limit!" ;
my $line = $*IN.get ;
my @parts = $line.words ;
my $base = +@parts[0] ;
my $limit = +@parts[1] ;
#by definition, all values from 0 to base - 1 are part of the solution
my @solution ;
for (0..$base - 1 ) -> $i {
   @solution.push( $i ) ;
}
for ($base..$limit - 1 ) -> $n {
   if ( isArmstrong( $n , $base ) ) {
      @solution.push( $n ) ;
   }
}
say '(' ~ @solution.join( ',' ) ~ ')' ;
