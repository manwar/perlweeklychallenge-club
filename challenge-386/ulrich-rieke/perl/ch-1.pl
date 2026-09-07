#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub createConversionTable {
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
   my %result ;
   for my $key ( keys( %conversions ) ) {
      $result{$conversions{$key}} = $key ;
   }
   return %result ;
}

sub convert {
   my $numberstring = shift ;
   my $base = shift ;
   my $table = shift ;
   my $result = 0 ;
   my $multiplier = 1 ;
   for my $c ( reverse split( // , $numberstring )) {
      my $factor = $multiplier * $table->{$c} ;
      $result += $factor ;
      $multiplier *= $base ;
   }
   return $result ;
}

say "Enter a number string in a given base!" ;
my $numberstring = <STDIN> ;
chomp $numberstring ;
say "Enter a base!" ;
my $base = <STDIN> ;
chomp $base ;
my %table = createConversionTable() ;
say convert( $numberstring , $base , \%table ) ;


