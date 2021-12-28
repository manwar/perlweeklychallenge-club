#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;

say "Enter an array of numbers!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers1 = split( /\s+/ , $line ) ;
say "Enter a second array of the same size!" ;
$line = <STDIN> ;
chomp $line ;
my @numbers2 = split( /\s+/ , $line ) ;
while ( scalar( @numbers2 ) != scalar( @numbers1 ) ) {
  say "The second array must contain as many numbers as the first one!" ;
  say "Re-enter!" ;
  $line = <STDIN> ;
  chomp $line ;
  @numbers2 = split( /\s+/ , $line ) ;
}
my @products ;
for my $i ( 0 .. scalar( @numbers1 ) - 1 ) {
  push @products , $numbers1[ $i ] * $numbers2[ $i ] ;
}
say sum( @products ) ;
