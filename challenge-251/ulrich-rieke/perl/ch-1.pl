#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $sum = 0 ;
while ( @numbers ) {
   if ( scalar( @numbers ) > 1 ) {
      my $concat = ($numbers[0] . $numbers[-1]) + 0 ;
      $sum += $concat ;
      shift @numbers ;
      pop @numbers ;
   }
   else {
      $sum += $numbers[0] ;
      shift @numbers ;
   }
}
say $sum ;
      
