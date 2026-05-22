#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string consisting of grouped digits only!" ;
my $number = <STDIN> ;
chomp $number ;
my %frequencies ; #for the frequencies of digits
map { $frequencies{$_}++ } split( // , $number ) ;
my $maxi = 0 ; # greatest number so far
for my $k( keys %frequencies ) {
   if ( $k ne '0' ) {
      my $current = ( $k x $frequencies{$k} ) + 0 ;
      if ( $current > $maxi ) {
         $maxi = $current ;
      }
   }
}
say $maxi ;
