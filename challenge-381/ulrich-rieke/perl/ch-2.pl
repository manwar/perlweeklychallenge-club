#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any ) ;

say "Enter some integers separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len < 3 ) {
   say 0 ;
}
else {
   my @selected ;
   for my $num( @numbers ) {
      if ( (any{ $_ > $num } @numbers) && (any { $_ < $num } @numbers) ) {
         push( @selected , $num ) ;
      }
   }
   say scalar( @selected ) ;
}
