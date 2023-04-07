#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw( combinations ) ;
use List::Util qw ( sum all ) ;

sub findArrayDifference {
  my $superArray = shift ;
  my $subArray = shift ;
  my %firstHash ;
  my %secondHash ;
  for my $el ( @$superArray ) {
      $firstHash{ $el }++ ;
  }
  for my $el ( @$subArray ) {
      $secondHash{ $el }++ ;
  }
  my @difference ;
  for my $k ( keys %secondHash ) {
      $firstHash{ $k } -= $secondHash{ $k } ;
  }
  for my $k ( keys %firstHash ) {
      if ( $firstHash{ $k } > 0 ) {
    for my $i ( 0..$firstHash{ $k } - 1 ) {
        push @difference , $k ;
    }
      }
  }
  return @difference ;
}

sub findAverage {
  my $subarray = shift ;
  my $len = scalar( @$subarray ) ;
  my $sum = sum( @$subarray ) ;
  return $sum / $len ;
}

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len == 1 ) {
  say "true" ;
}
else { #$len > 1
  my $result = 0 ;
  if ( $len == 2 ) {
      if ( $numbers[ 0 ] == $numbers[1] ) {
    $result = 1 ;
      }
      else {
      }
  }
  else { # $len > 2
      my $limit = int( $len / 2 ) ;
      my $currentLen = $len - 1 ;
      COMBI: while ( $currentLen > $limit ) {
        my $iter = combinations(\@numbers, $currentLen ) ;
        while ( my $c = $iter->next ) {
          my @difference = findArrayDifference( \@numbers , $c ) ;
          if ( findAverage( \@difference ) == findAverage( $c ) ) {
              $result = 1 ;
              last COMBI ;
          }
        }
        $currentLen-- ;
        }
  }
  if ( $result ) {
      say "true" ;
  }
  else {
      say "false" ;
  }
}
