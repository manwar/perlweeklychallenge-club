#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my $N = $ARGV[ 0 ] ;
while ( $N !~ /\A\d+\z/ ) {
  say "Please enter a positive integer!" ;
  $N = <STDIN> ;
  chomp $N ;
}
my $current = 0 ;
while ( $current * $current < $N ) {
  $current++ ;
}
if ( $current * $current == $N ) {
  say $current ;
}
else {
  say --$current ;
}
