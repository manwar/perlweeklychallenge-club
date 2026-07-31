#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#create conversion table from hex to decimal
sub createConversion {
   my %conversion ;
   my $numbers = "0123456789" ;
   my $n = 0 ;
   for my $i (split( // , $numbers)) {
      $conversion{$i} = $n ;
      $n++ ;
   }
   my $helper = "ABCDEF" ;
   $n = 10 ;
   for my $letter( split( // , $helper ) ) {
      $conversion{$letter} = $n ;
      $n++ ;
   }
   return %conversion ;
}

sub roundRGB {
   my $color = shift ;
   my $converted ;
   $converted .= "#" ;
   my %websafes = ( "00" => 0 , "33" => 51 , "66" => 102 , "99" => 153 , 
         "CC" => 204 , "FF" => 255 ) ;
   my %hex_to_value ;
   for my $key( keys( %websafes ) ) {
      $hex_to_value{ $websafes{$key} } = $key ;
   }
   my %conversion = createConversion( ) ;
   my $colorpart = substr( $color , 1 ) ;
   for my $n( 0..2) {
      my $part = substr( $colorpart , 2 * $n , 2 ) ;
      my $number = $conversion{ substr( $part , 0 , 1 ) } * 16 + 
         $conversion{ substr( $part , 1 , 1 ) } ;
      my @sorted = sort { abs( $a - $number ) <=> abs( $b - $number ) } 
       values %websafes ;
      $converted .= $hex_to_value{ $sorted[0] } ;
   }
   return $converted ;
}

say "Enter a RGB color!" ;
my $color = <STDIN> ;
chomp $color ;
say roundRGB( $color ) ;
