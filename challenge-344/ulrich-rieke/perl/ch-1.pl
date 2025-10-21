#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @digits = split( /\s/ , $line ) ;
say "Enter an integer!" ;
my $x = <STDIN> ;
chomp $x ;
my $pos = 0 ;
my $total = 0 ;
my @reversed = reverse @digits ;
for my $digit ( @reversed ) {
   $total += $digit * 10 ** $pos ;
   $pos++ ;
}
my $result = $total + $x ;
say '(' . join( ',' , decompose( $result ) ) . ')' ;

sub decompose {
   my $number = shift ;
   my @result ;
   while ( $number != 0 ) {
      push( @result , $number % 10 ) ;
      $number = int( $number / 10 ) ;
   }
   my @resultArray = reverse @result ;
   return @resultArray ;
}
