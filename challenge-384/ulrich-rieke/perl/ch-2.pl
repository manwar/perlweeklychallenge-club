#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub condition {
   my $word = shift ;
   my $l = length $word  ;
   my $half = $l / 2 ;  #we assume length to be even-numbered!
   my $firsthalf = '0' x $half ; 
   my $secondhalf = '1' x $half ;
   if ( (substr( $word , 0 , $half ) eq $firsthalf) && ( substr( $word , 
               $half ) eq $secondhalf ) || ( substr( $word , 0 , $half )
               eq $secondhalf && substr( $word , $half ) eq $firsthalf )) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter a binary string consisting of 0 and 1 only!" ;
my $binary = <STDIN> ;
chomp $binary ;
if ( all { $_ eq '0' } split( // , $binary ) || all { $_ eq '1' } split( 
 // , $binary )) {
   say "()" ;
}
else {
   my @sequences ; #for the final solution
   my $l = length( $binary ) ;
#for every start position in the string , go as far right as is necessary
#to fulfil the condition above if there is such a string. If so , add it
#to the @sequences array
   for my $pos( 0..$l - 2 ) {
      for my $len( 2..$l - $pos) {
         my $inner = substr( $binary , $pos , $len ) ;
         if ( condition( $inner ) ) {
            push( @sequences , $inner ) ;
            last ;
         }
      }
   }
   say '(' . join( ',' , @sequences ) . ')' ;
}
   
