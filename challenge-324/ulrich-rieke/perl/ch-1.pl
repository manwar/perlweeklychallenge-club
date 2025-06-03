#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
say "Enter number of rows and columns!" ;
$line = <STDIN> ;
chomp $line ;
my ( $rows , $columns ) = split( /\s/ , $line ) ;
if ( $rows * $columns != scalar( @numbers )) {
   say "The product of rows and columns must equal the element number!" ;
}
else {
   my @array ;
   my $pos = 0 ;
   for my $r( 0..$rows - 1 ) {
      my @row ;
      for my $c( 0..$columns - 1 ) {
	 push( @row , $numbers[$pos] ) ;
	 $pos++ ;
      }
      push( @array , \@row ) ;
   }
   print '(' ;
   for my $a ( @array ) {
      print '[' ;
      print join( ',' , @$a ) . "] " ;
   }
   say ")" ;
}

