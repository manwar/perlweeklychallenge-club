#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
say "Enter a width!" ;
my $width = <STDIN> ;
chomp $width ;
my $len = length $word ;
my $output ;
if ( $len == 0 ) {
   for (0..$width - 1 ) {
      $output .= '*' ;
   }
}
else {
   my $left = int( ($width - $len) / 2 ) ;
   for (0..$left - 1 ) {
      $output .= '*' ;
   }
   $output .= $word ;
   for (0.. $width - $len - $left - 1 ) {
      $output .= '*' ;
   }
}
say $output ;

