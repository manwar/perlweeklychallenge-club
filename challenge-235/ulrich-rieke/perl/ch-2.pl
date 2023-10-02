#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @result ;
my $len = scalar( @numbers ) ;
for my $n ( @numbers ) {
   if ( $n != 0 ) {
      push @result , $n ;
   }
   else {
      for (1 , 2 ) {
	 push @result , 0 ;
      }
   }
}
say "(" . join( ',' , @result[0..$len - 1] ) . ")" ;
