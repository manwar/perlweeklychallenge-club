#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( max ) ;

say "Enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my %numberHash ;
my @allSums ;
map { $numberHash{ $_ }++ } @numbers ;
for my $num ( sort { $a <=> $b } keys %numberHash ) {
  my $sum = 0 ;
  for my $i ( $num - 1 , $num , $num + 1 ) {
      if ( exists( $numberHash{ $i } ) ) {
    $sum += $i * $numberHash{ $i } ;
      }
  }
  push @allSums, $sum ;
}
say max( @allSums ) ;
