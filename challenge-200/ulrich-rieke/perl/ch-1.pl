#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Algorithm::Combinatorics qw ( combinations ) ;
use List::Util qw ( all ) ;

sub myCondition {
  my $array = shift ;
  my $len = scalar( @$array ) ;
  my @differences ;
  for my $i (0.. $len - 2 ) {
      push @differences , $array->[$i + 1] - $array->[ $i ] ;
  }
  return all { $_ == $differences[ 0 ] } @differences ;
}

say "Please enter some integers, separated by a blank!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
if ( $len < 3 ) {
  say "()" ;
}
else {
  my $fulfilled = 0 ;
  for my $l (3..$len) {
      my $iter = combinations(\@numbers , $l ) ;
      while ( my $p = $iter->next ) {
    if ( myCondition( $p ) ) {
        say "(" . join( ',' , @$p ) . ")" ;
        $fulfilled = 1 ;
    }
      }
      unless ( $fulfilled ) {
    say "( )" ;
      }
  }
}
