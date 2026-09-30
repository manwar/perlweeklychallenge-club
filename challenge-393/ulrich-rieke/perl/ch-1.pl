#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
my $total = 0 ;
for my $a (1..$number) {
   for my $b (1..$number) {
      for my $c (1..$number) {
         if ( $a * $a + $b * $b == $c * $c ) {
            $total++ ;
         }
      }
   }
}
say $total ;
