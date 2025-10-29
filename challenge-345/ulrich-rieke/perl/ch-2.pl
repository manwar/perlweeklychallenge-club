#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some positive integers or -1 separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @seen ;
my @answer ;
my $x = 0 ;
my @numbers = split( /\s/ , $line ) ;
my $pos = 0 ;
my $len = scalar( @numbers ) ;
while ( $pos < $len ) {
   my $num = $numbers[$pos] ;
   if ( $num > 0 ) {
      $x = 0 ;
      unshift( @seen , $num ) ;
   }
   else {
      if ( $x < scalar( @seen ) ) {
	 push( @answer , $seen[$x] ) ;
      }
      else {
	 push( @answer , -1 ) ;
      }
      if ( $pos < $len - 1 && $numbers[$pos + 1] == -1 ) {
	 $x++ ;
      }
   }
   $pos++ ;
}
say '(' . join( ',' , @answer ) . ')' ; 

