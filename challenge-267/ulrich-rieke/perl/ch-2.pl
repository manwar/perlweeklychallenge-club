#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a string!" ;
my $string = <STDIN> ;
chomp $string ;
say "Enter 26 character widths, separated by ',' !" ;
my $widths = <STDIN> ;
chomp $widths ;
my $characters = "abcdefghijklmnopqrstuvwxyz" ;
my @chars = split( // , $characters ) ;
my %charwidths ;
my @cwidths = split( ',' , $widths ) ;
for my $pos ( 0..25) {
   $charwidths{ $chars[ $pos ] } = $cwidths[ $pos ] ;
}
my $sum = 0 ;
my $lineno = 1 ;
my $pixels = 0 ;
for my $letter ( split( // , $string ) ) {
   $sum += $charwidths{ $letter } ;
   if ( $sum > 100 ) {
      $lineno++ ;
      $sum = $charwidths{ $letter } ;
   }
   if ( $sum == 100 ) {
      $lineno++ ;
      $sum = 0 ;
   }
}
if ( $sum == 0 ) {
   $lineno-- ;
}
$pixels = $sum ;
say "($lineno , $pixels)" ;
