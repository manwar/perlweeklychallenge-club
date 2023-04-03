#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;

sub eliminate_values {
  my $array = shift ;
  my @after_elimination ;
  my $len = scalar( @$array ) ;
  my $pos = 0 ;
  while ( not ( $array->[ $pos] > 0 && $array->[ $pos + 1 ] < 0 ) ) {
      push @after_elimination, $array->[ $pos ] ;
      $pos++ ;
  }
  my $diff = abs( $array->[$pos] ) - abs( $array->[ $pos + 1 ] ) ;
  if ( $diff > 0 ) {
      push @after_elimination , $array->[$pos] ;
  }
  elsif ( $diff == 0 ) {
  }
  else {
      push @after_elimination, $array->[ $pos + 1 ] ;
  }
  $pos += 2 ;
  if ( $pos < $len ) {
      while ( $pos < $len ) {
    push @after_elimination, $array->[ $pos ] ;
    $pos++ ;
      }
  }
  return @after_elimination ;
}

sub needs_no_collisions {
  my $numbers = shift ;
  my $len = scalar( @$numbers ) ;
  my @indices ;
  for my $i ( 0..$len - 2 ) {
      push @indices , $i ;
  }
  return scalar( grep { not ( $numbers->[ $_ ] > 0 && $numbers->[ $_ + 1 ] < 0 ) }
    @indices ) == scalar( @indices ) ;
}

say "Enter some positive and negative integers, separated by breaks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @after_collision = eliminate_values(\@numbers ) ;
while ( not needs_no_collisions(\@after_collision )) {
  @after_collision = eliminate_values(\@after_collision) ;
}
if ( @after_collision ) {
  print '(' ;
  print join( ',' , @after_collision ) ;
  say ')' ;
}
else {
  say "()" ;
}
