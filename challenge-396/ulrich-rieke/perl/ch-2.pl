#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any all ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $l = scalar( @numbers ) ;
my @differences ;
for my $pos( 0..$l - 2) {
   push( @differences , $numbers[$pos] - $numbers[$pos + 1] ) ;
}
if ( any { $_ == 0 } @differences ) {
   say "false" ;
}
else {
   my $len = $l - 1 ; #length of @differences !
   my @firstPart ;
   my @secondPart ;
   my @thirdPart ;
   my $pos = 0 ;
   while (  ($pos < $len ) && ( $differences[$pos] < 0 )) {
      push( @firstPart , $differences[$pos] ) ;
      $pos++ ;
   }
   while ( ( $pos < $len ) && ($differences[$pos] > 0) ) {
      push( @secondPart , $differences[$pos] ) ;
      $pos++ ;
   }
   while ( ( $pos < $len ) && ($differences[$pos] < 0) ) {
      push( @thirdPart , $differences[$pos] ) ;
      $pos++ ;
   }
   my ( $f , $s , $t ) = ( scalar( @firstPart ) , scalar( @secondPart ) , 
         scalar( @thirdPart ) ) ;
   if ( $f + $s + $t == $len && all { $_ > 0 } ( $f , $s , $t ) ) {
      say "true" ;
   }
   else {
      say "false" ;
   }
}
