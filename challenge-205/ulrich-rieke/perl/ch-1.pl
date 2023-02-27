#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

my %uniques ;
map { $uniques{$_}++ } @ARGV ;
my @unique = keys %uniques ;
my @sorted = sort { $b <=> $a } @unique ;
if ( scalar( @unique ) < 3 ) {
  say $sorted[0] ;
}
else {
  say $sorted[2] ;
}
