#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub findEnd {
  my $array = shift ;
  my $pos = shift ;
  my $current_index = $pos ;
  $current_index++ ;
  if ( $current_index > scalar( @{$array} ) - 1 ) {
      return $pos ;
  }
  else {
      my $current = $array->[ $current_index ] ;
      while ( $current - $array->[ $current_index - 1 ] == 1 ) {
    $current_index++ ;
    if ( $current_index < scalar( @{$array} )) {
        $current = $array->[ $current_index ] ;
    }
    else {
        last ;
    }
      }
      $current_index-- ;
      return $current_index ;
  }
}

say "Please enter a sorted array of unique integers!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my %numberFreq ;
map { $numberFreq{ $_ }++ } @numbers ;
my @sorted = sort { $a <=> $b } @numbers ;
if ( @sorted != @numbers || scalar( keys %numberFreq ) != scalar( @numbers ) ) {
  say "Please enter a sorted array of unique numbers!" ;
  $line = <STDIN> ;
  chomp $line ;
  @numbers = split( /\s/ , $line ) ;
}
my @subsequences ;
my $pos = 0 ;
my $len = scalar( @numbers ) ;
while ( $pos < $len - 1 ) {
  my $end = findEnd( \@numbers, $pos ) ;
  if ( $end - $pos > 0 ) {
      push( @subsequences , [ $numbers[ $pos ] , $numbers[ $end ] ] ) ;
  }
  $pos = $end + 1 ;
}
say join( ',' , map { "[" . join( ',' , @{$_} ) . "]" } @subsequences ) ;
