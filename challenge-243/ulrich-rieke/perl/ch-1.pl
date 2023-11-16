#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my $sum = 0 ;
for my $i ( 0..$len - 2 ) {
   for my $j ( $i + 1 .. $len - 1 ) {
      if ( $numbers[ $i ] > 2 * $numbers[ $j ] ) {
	 $sum++ ;
      }
   }
}
say $sum ;