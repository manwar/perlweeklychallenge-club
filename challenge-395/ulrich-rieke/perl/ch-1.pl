#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub parseNumber {
   my $number = shift ;
   my $real ;
   my $imaginary ;
   if ( $number =~ /^\-?(\d+)\+(.+)i$/ ) {
      $real = $1 ;
      my $imagepart = $2 ;
      if ( $number =~ /^\-/ ) {
         $real *= -1 ;
      }
      if ( $imagepart =~ /(\d+)/ ) {
         $imaginary = $1 ;
      }
      if ( $imagepart =~ /\(/ ) {
         $imaginary *= -1 ;
      }
   }
   my @array = ($real , $imaginary ) ;
   return @array ;
}

say "Enter 2 complex numbers as strings!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my ( $firstre , $firstimag ) = parseNumber( $numbers[0] ) ;
my ( $secondre , $secondimag ) = parseNumber( $numbers[1] ) ;
my $resultre = $firstre * $secondre - $firstimag * $secondimag ;
my $resultim = $firstimag * $secondre + $firstre * $secondimag ;
my $output = $resultre . '+' ;
if ( $resultim < 0 ) {
   $output .= '(' ;
}
$output .= $resultim ;
if ( $resultim < 0 ) {
   $output .= ')' ;
}
$output .= "i" ;
say $output ;
