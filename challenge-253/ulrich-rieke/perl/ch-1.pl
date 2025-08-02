#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some strings, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @strings = split( /\s/ , $line ) ;
say "Enter a separator!" ;
my $sep = <STDIN> ;
chomp $sep ;
my @result ;
for my $str( @strings ) {
   my $pos = index( $str , $sep ) ;
   while ( $pos != -1 ) {
      substr( $str , $pos , 1 ) = " " ;
      $pos = index( $str , $sep , $pos + 1) ;
   }
   my @parts = split( /\s/ , $str ) ;
   for my $p ( @parts ) {
      push @result, $p ;
   }
}
say ( "(" . join( ',' , grep {length $_ > 0 } @result ) . ")" ) ;
