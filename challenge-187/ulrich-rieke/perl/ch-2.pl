#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( permutations combinations ) ;
use List::Util qw ( sum ) ;

say "Enter a line of positive integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my @combis ;
my $iter = combinations( \@numbers , 3 ) ;
while ( my $p = $iter->next( ) ) {
  push @combis , $p  ;
}
my %uniquePermus ;
for my $list ( @combis ) {
  my $iter = permutations( \@$list ) ;
  while ( my $p = $iter->next ) {
      $uniquePermus{ join( '|' , @$p )}++ ;
  }
}
my @solution ;
my $maximum = 0 ;
for my $triple ( keys %uniquePermus ) {
  my @triplet = split( /\|/ , $triple ) ;
  if ( sum( @triplet ) > $maximum ) {
      $maximum = sum( @triplet ) ;
  } ;
}
for my $triple( keys %uniquePermus ) {
  my @triplet = split( /\|/ , $triple ) ;
  if ( ($triplet[0] + $triplet[1] > $triplet[2]) &&
        ($triplet[1] + $triplet[2] > $triplet[0] ) &&
    ($triplet[0] + $triplet[2] > $triplet[1] ) &&
    ( sum( @triplet ) == $maximum )) {
      push @solution, [$triplet[0] , $triplet[1] , $triplet[2]] ;
  }
}
if ( scalar( @solution ) > 1 ) {
  @solution = grep { ($_->[0] >= $_->[1]) && ( $_->[1] >= $_->[2] ) }
  @solution ;
}
if ( @solution ) {
  for my $trip ( @solution ) {
      say "(" . $trip->[0] . ',' . $trip->[1] . ',' . $trip->[2] . ')' ;
  }
}
else {
  say "()" ;
}
