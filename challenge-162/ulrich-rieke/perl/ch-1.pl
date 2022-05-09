#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter an ISBN with only 12 digits!" ;
my $isbn = <STDIN> ;
chomp $isbn ;
my $converted = $isbn ;
$converted =~ s/\D//g ;
while ( length $converted != 12 ) {
  say "For the purposes of this exercise, the ISBN should only have 12 digits!" ;
  $isbn = <STDIN> ;
  $converted = $isbn ;
  $converted =~ s/\D//g ;
}
my @multipliers ;
for (1 .. 6 ) {
  push @multipliers , 1 , 3 ;
}
my @numbers = split( // , $converted ) ;
my $sum = 0 ;
for my $i ( 0 .. 11 ) {
  $sum += $numbers[ $i ] * $multipliers[ $i ] ;
}
my $check = 10 - ( $sum % 10 ) ;
if ( $check == 10 ) {
  $check = 0 ;
}
say "The correct ISBN number is $isbn" . $check . " !" ;
