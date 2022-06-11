#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum max ) ;
use Algorithm::Combinatorics qw ( combinations ) ;

sub checkCondition {
  my $numbers = shift ;
  my $len = scalar( @$numbers ) ;
  for my $i ( 0 .. $len - 2 ) {
      if ( abs( $numbers->[$i] - $numbers->[ $i + 1 ] ) == 1 ) {
    return 0 ;
      }
  }
  return 1 ;
}

say "Enter some values, separated by blank spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @valuables = split( /\s+/ , $line ) ;
my $len = scalar( @valuables ) ;
if ( $len == 1 ) {
  say $valuables[0] ;
}
elsif ( $len == 2 ) {
  say max( @valuables ) ;
}
else {
  if ( $len == 3 ) {
      if ( $valuables[0] + $valuables[2] > $valuables[1] ) {
    say ( $valuables[0] + $valuables[2] ) ;
      }
      else {
    say $valuables[ 1 ] ;
      }
  }
  else { # $len > 3
      my @robbedValues ;
      my @combilengths ;
      if ( $len % 2 == 1 ) {
    push @combilengths , int( $len / 2 ) , int( $len / 2 ) + 1 ;
      }
      else {
    push @combilengths, int( $len / 2 ) ;
      }
      my @positions = (0 .. $len - 1 ) ;
      for my $combilen ( @combilengths ) {
    my $iter = combinations( \@positions, $combilen ) ;
    while ( my $c = $iter->next ) {
        if ( checkCondition( $c ) ) {
          push @robbedValues , sum (@valuables[ @$c ]) ;
        }
    }
      }
      say max( @robbedValues ) ;
  }
}
