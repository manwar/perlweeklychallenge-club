#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a square matrix of n x n elements, n > 2 , end to end input!" ;
my @allNumbers ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ne "end" ) {
  my @numbers = split( /\s/ , $line ) ;
  map { push @allNumbers , $_ } @numbers ;
  $line = <STDIN> ;
  chomp $line ;
}
my @sorted = sort { $a <=> $b } @allNumbers ;
say $sorted[ 2 ] ;
