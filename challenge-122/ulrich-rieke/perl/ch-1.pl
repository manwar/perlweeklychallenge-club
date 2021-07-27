#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enterArray {
  say "Enter numbers, separated by blanks" ;
  my $line = <STDIN> ;
  chomp $line ;
  my @array = split( /\s+/ , $line ) ;
  return @array ;
}

my @array = enterArray( ) ;
my @averages ;
my $len = scalar @array ;
my $sum = 0 ;
for my $i (0 .. $len - 1 ) {
  $sum += $array[ $i ] ;
  my $av = $sum / ( $i + 1 ) ;
  push @averages , $av ;
}
say join( ", " , @averages ) ;
