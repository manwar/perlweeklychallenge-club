#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub enterArray {
  my @array ;
  say "Enter number ( 'e' to end )!" ;
  my $line = <STDIN> ;
  chomp $line ;
  while ( $line ne 'e' ) {
      if ( $line =~ /\b[-]*\d+\b/ ) {
    push( @array , $line ) ;
      }
      say "Next number :" ;
      $line = <STDIN> ;
      chomp $line ;
  }
  return @array ;
}

my @array = enterArray( ) ;
my $len = scalar @array ;
my $candies = $len ;
for my $i ( 0 .. $len - 1 ) {
  if ( $i < $len - 1 ) {
      if ( $array[ $i ] > $array[ $i + 1 ] ) {
    $candies++ ;
      }

  }
  if ( $i > 0 ) {
      if ( $array[ $i ] > $array[ $i - 1 ] ) {
    $candies++ ;
      }
  }
}
say " " ;
say $candies ;

