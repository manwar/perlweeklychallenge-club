#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#it more or less a translation of the Raku solution, assume the comments
#to be added here

sub humandraw {
  my $parts = shift ;
  say "How many pieces do you want to take ?" ;
  my $takeaway = <STDIN> ;
  chomp $takeaway ;
  while ( $takeaway > 3 ) {
      say "don't take more than 3 pieces!" ;
      $takeaway = <STDIN> ;
      chomp $takeaway ;
  }
  $parts -= $takeaway ;
  say "We now have $parts pieces!" ;
  return $parts ;
}

sub computerdraw {
  my $firstDraw = shift ;
  my $parts = shift ;
  my $takeaway ;
  if ( $firstDraw ) {
      $takeaway = 2 ;
  }
  else {
      if ( $parts > 8 and $parts < 12 ) {
    $takeaway = $parts - 8 ;
      }
      if ( $parts > 4 and $parts < 8 ) {
    $takeaway = $parts - 4 ;
      }
      if ( $parts == 4 ) {
    $takeaway = 1 ;
      }
      if ( $parts == 8 ) {
    $takeaway = 1 ;
      }
      if ( $parts > 0 and $parts < 4 ) {
    $takeaway = $parts ;
      }
  }
  $parts -= $takeaway ;
  say "I took $takeaway piece(s)!" ;
  say "We now have $parts piece(s)!" ;
  return $parts ;
}

my $pieces = 12 ;
my $firstDraw = 1 ;
my $num = rand ;
if ( $num < 0.5 ) {
  say "You start!" ;
  $firstDraw = 0 ;
  while ( $pieces > 0 ) {
      $pieces = humandraw( $pieces ) ;
      if ( $pieces == 0 ) {
    say "You won!" ;
    last ;
      }
      $pieces = computerdraw( $firstDraw , $pieces ) ;
      if ( $pieces == 0 ) {
    say "I won!" ;
    last ;
      }
  }
}
else {
  say "I start!" ;
  while ( $pieces > 0 ) {
      $pieces = computerdraw( $firstDraw, $pieces ) ;
      $firstDraw = 0 ;
      if ( $pieces == 0 ) {
    say "I won!" ;
    last ;
      }
      $pieces = humandraw( $pieces ) ;
      if ( $pieces == 0 ) {
    say "You won!" ;
    last ;
      }
  }
}
