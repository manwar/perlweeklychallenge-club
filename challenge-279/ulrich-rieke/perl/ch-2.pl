#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#the task amounts to verifying whether the number of vowels in the string
#is even or odd
say "Enter a string!" ;
my $line = <STDIN> ;
chomp $line ;
my $vowels = "aeiouAEIOU" ;
if ( scalar( grep { index( $vowels , $_ ) != -1 } split( // , $line ) ) 
      % 2 == 0 ) {
   say "true" ;
}
else {
   say "false" ;
}
