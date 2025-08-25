#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter some numbers and the letters C , D or + separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @parts = split( /\s+/ , $line ) ;
my @numbers ;
my $len = scalar( @parts ) ;
my $pos = 0 ;
while ( $pos < $len && $parts[$pos] =~ /\d+/ ) {
   push( @numbers , $parts[$pos] ) ;
   $pos++ ;
}
for my $p ($pos..$len - 1) {
   if ( $parts[$p] =~ /C|D|\+/ ) {
      if ( $parts[$p] eq 'C' ) {
	 pop( @numbers ) ;
      }
      if ( $parts[$p] eq 'D' ) {
	 push( @numbers , $numbers[-1] * 2 ) ;
      }
      if ( $parts[$p] eq '+' ) {
	 my $l = scalar( @numbers ) ;
	 push( @numbers , $numbers[$l - 2 ] + $numbers[$l - 1] ) ;
      }
   }
   else { #it must be a number !
      push( @numbers , $parts[$p] ) ;
   }
}
say sum( @numbers ) ;
