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
for my $i (0..$len - 1 ) {
   if ( $len % ( $i + 1 ) == 0 ) {
      $sum += $numbers[ $i ] ** 2 ;
   }
}
say $sum ;
