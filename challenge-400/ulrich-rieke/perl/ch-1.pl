#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub isRepeating {
   my $number = shift ;
   if ( $number > 9 ) {
      my %frequencies ;
      my @digits ;
      while ( $number != 0 ) {
         my $remainder = $number % 10 ;
         push( @digits , $remainder ) ;
         $frequencies{$remainder}++ ;
         $number = int( $number / 10 ) ;
      }
      if ( scalar( keys( %frequencies )) != 
            scalar( @digits ) ) {
         return 1 ;
      }
      else {
         return 0 ;
      }
   }
   else {
      return 0 ;
   }
}

say "Enter a positive integer!" ;
my $number = <STDIN> ;
chomp $number ;
my @selected = grep { not ( isRepeating( $_ )) } (1..$number) ;
my $len = scalar( @selected ) ;
my $maxi = 0 ;
for my $i ( 1..$len - 1 ) {
   my $diff = $selected[$i] - $selected[$i - 1] ;
   if ( $diff > $maxi ) {
      $maxi = $diff ;
   }
}
say $maxi ;

