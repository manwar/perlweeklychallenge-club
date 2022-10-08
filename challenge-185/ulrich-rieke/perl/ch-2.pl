#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub mySubstitute {
  my $word = shift ;
  my $pos = 0 ;
  my $count = 0 ;
  while ( $count < 4 ) {
      if ( substr( $word , $pos , 1 ) =~ /\w/ ) {
    substr( $word, $pos , 1 ) = "x" ;
    $count++ ;
    $pos++ ;
      }
      else {
    $pos++ ;
      }
  }
  return $word ;
}

say "Please enter some codes, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @codes = split( /\s/ , $line ) ;
my @changed = map { mySubstitute( $_ ) } @codes ;
say join ( ',' , @changed ) ;
