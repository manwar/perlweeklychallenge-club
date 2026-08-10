use v6 ;

#when split at halfpoint both parts must contain equally many 0 and 1
sub condition( $binString ) {
   my $l = $binString.chars ;
   my $half = $l div 2 ;
   my $firstpart = '0' x $half ;
   my $secondpart = '1' x  $half ;
   my $first = $binString.substr( 0 , $half) ;
   my $second = $binString.substr( $half ) ;
   return ( ($first eq $firstpart) && ($second eq $secondpart ) ) || 
      (( $first eq $secondpart ) && ( $second eq $firstpart ) ) ;
}


say "Enter a binary string consisting of 0 and 1 only!" ;
my $binary = $*IN.get ;
if (so '0' == ($binary.comb).all) || ( so '1' == ($binary.comb).all ) {
   say "()" ;
}
else {
   my @subsequences ; #for the final solution
#for every position in the binary, walk as far right in the string until
#you find a string that fulfils the condition if there is one , the
#enter it in the @subsequences array ;
   my $l = $binary.chars ;   
   for (0..$l - 2) -> $pos {
      for (2..$l - $pos) -> $num {
         if ( condition( $binary.substr( $pos , $num ) )) {
            @subsequences.push( $binary.substr( $pos , $num )) ;
           last ;
         }
      }
   }
   say '(' ~ @subsequences.join( ',' ) ~ ')' ;
}
