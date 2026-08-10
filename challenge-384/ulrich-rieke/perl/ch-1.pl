#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
sub convert {
   my $number = shift ;
   my $base = shift ;
   my %conversions ;
   for my $i (0..9) {
      $conversions{$i} = chr( $i + 48 ) ;
   }
   for my $i (10..36) {
      $conversions{$i} = chr( $i + 55 ) ;
   }
   for my $i (37..63) {
      $conversions{$i} = chr( $i + 61 ) ;
   }
   $conversions{64} = '+' ;
   $conversions{65} = '/' ;
   my $converted ;
   while ( $number != 0 ) {
      $converted .= $conversions{ $number % $base } ;
      $number = floor( $number / $base ) ;
   }
   my $result ;
   for my $letter( reverse( split( // , $converted ) )) {
      $result .= $letter ;
   }
   return $result ;
}

say "Enter a number and a base!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $number , $base ) = split( /\s/ , $line ) ;
say convert( $number , $base ) ;
