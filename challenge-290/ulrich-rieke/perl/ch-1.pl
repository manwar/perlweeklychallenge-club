#!/usr/bin/perl ;
use strict ; 
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my $len = scalar( @numbers ) ;
my $result = "false" ;
for my $outer( 0..$len - 2 ) {
   if ( $numbers[$outer] > 1 ) {
      for my $inner( $outer + 1 .. $len - 1 ) {
	 if ( $numbers[$outer] == 2 * $numbers[$inner] ) {
	    $result = "true" ;
	    last ;
	 }
      }
   }
}
say $result ;
