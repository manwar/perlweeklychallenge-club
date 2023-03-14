#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @sorted = sort { $b <=> $a } @numbers ;
my @possible_h ;
for my $i ( 0..scalar( @sorted ) - 1 ) {
  if ( $sorted[ $i ] >= ( $i + 1 ) ) {
      push @possible_h , $i + 1 ;
  }
}
say max @possible_h ;
