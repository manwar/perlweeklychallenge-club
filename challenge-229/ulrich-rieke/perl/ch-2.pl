#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter first line of numbers!" ;
my $line = <STDIN> ;
chomp $line ;
my %firstHash ;
for my $elem ( split( /\s/ , $line ) ) {
   $firstHash{ $elem }++ ;
}
say "Enter second line of numbers!" ;
$line = <STDIN> ;
chomp $line ;
my %secondHash ;
for my $elem( split( /\s/ , $line ) ) {
   $secondHash{ $elem }++ ;
}
say "Enter third line of numbers!" ;
$line = <STDIN> ;
chomp $line ;
my %thirdHash ;
for my $elem( split( /\s/ , $line ) ) {
   $thirdHash{ $elem }++ ;
}
my %firstIntersect ;
for my $num ( keys %firstHash ) {
   if ( exists( $secondHash{ $num } ) ) {
      $firstIntersect{ $num }++ ;
   }
}
my %secondIntersect ;
for my $num ( keys %secondHash ) {
   if ( exists( $thirdHash{ $num } ) ) {
      $secondIntersect{ $num }++ ;
   }
}
my %thirdIntersect ;
for my $num ( keys %firstHash ) {
   if ( exists( $thirdHash{ $num } ) ) {
      $thirdIntersect{ $num }++ ;
   }
}
my %result ;
for my $elem ( keys %firstIntersect ) {
   $result{ $elem }++ ;
}
for my $elem ( keys %secondIntersect ) {
   $result{ $elem }++ ;
}
for my $elem ( keys %thirdIntersect ) {
   $result{ $elem }++ ;
}
say '(' . join( ',' , sort { $a <=> $b } keys %result ) . ')' ;
