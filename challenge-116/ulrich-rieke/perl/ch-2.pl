#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX qw ( floor ) ;
use List::Util qw ( sum ) ;

my $N = $ARGV[0] ;
if ( $N < 10 ) {
  die "number must be greater than 9!" ;
}
my @squarenums = map { $_ ** 2 } split (// , $N ) ;
my $squaresum = sum @squarenums ;
if ( floor( sqrt( $squaresum ) ) == sqrt( $squaresum ) ) {
  say 1 ;
}
else {
  say 0 ;
}
