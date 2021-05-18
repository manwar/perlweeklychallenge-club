#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( sum ) ;
use Algorithm::Combinatorics qw ( combinations ) ;

my $N = $ARGV[0] ;
my $D = $ARGV[ 1 ] ;
my @possibleNumbers = grep { $_ =~ /$D/ } (1 .. $N) ;
my $nums = scalar @possibleNumbers ;
if ( $N == $D ) {
  say 1 ;
  exit( 0 ) ;
}
else {
  if ( $nums == 0 or $nums == 1 ) {
      say 0 ;
      exit( 1 ) ;
  }
  if ( $nums == 2 ) {
      if ( $possibleNumbers[ 0 ] + $possibleNumbers[1] == $N ) {
    say 1 ;
    exit( 0 ) ;
      }
      else {
    say 0 ;
    exit( 1 ) ;
      }
  }
  if ( $nums > 2 ) {
      for my $i ( 2 .. $nums ) {
    my $iter = combinations( \@possibleNumbers , $i ) ;
    while ( my $p = $iter->next ) {
        if ( sum( @$p ) == $N ) {
          say 1 ;
          exit( 0 ) ;
        }
    }
      }
      say 0 ;
  }
}
