#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an alphabetic string!" ;
my $word = <STDIN> ;
chomp $word ;
#create pairs of neighbouring characters , convert them to either uppercase
#or lowercase and count the number of pairs with unequal letters
my @pairs ;
my $pos = 0 ;
while ( $pos < length( $word ) - 2 ) {
   push( @pairs , substr( $word , $pos , 2 ) ) ;
   push( @pairs , substr( $word , $pos + 1 , 2 )) ;
   $pos += 2 ;
}
say scalar( grep { substr( $_ , 0 , 1 ) ne substr( $_ , 1 , 1 ) } map {
join ( '' , map { lc } split( // , $_ )) } @pairs ) ;
